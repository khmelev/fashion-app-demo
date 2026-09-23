package server

import (
	"context"
	"log"

	pb "fashion-grpc/proto"

	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/status"
)

// ProductServer implements the generated pb.ProductServiceServer interface.
type ProductServer struct {
	// Embedding this struct gives us default (Unimplemented) behaviour
	// for any RPC we haven't written yet, so adding new methods to the
	// .proto file later won't break compilation here.
	pb.UnimplementedProductServiceServer
}

// NewProductServer builds a ProductServer.
func NewProductServer() *ProductServer {
	return &ProductServer{}
}

// ListProducts returns a fixed, in-memory catalog. In a real service this
// would query a database; here it's hardcoded on purpose for learning.
func (s *ProductServer) ListProducts(ctx context.Context, req *pb.ListProductsRequest) (*pb.ListProductsResponse, error) {
	log.Println("ListProducts called")

	return &pb.ListProductsResponse{Products: mockProducts}, nil
}

// GetProduct looks up a single product by id in the hardcoded catalog.
func (s *ProductServer) GetProduct(ctx context.Context, req *pb.GetProductRequest) (*pb.Product, error) {
	log.Printf("GetProduct called with id=%q", req.GetProductId())

	for _, p := range mockProducts {
		if p.Id == req.GetProductId() {
			return p, nil
		}
	}

	return nil, status.Errorf(codes.NotFound, "product %q not found", req.GetProductId())
}

// GetSimilar returns up to 10 products from the catalog, excluding the one
// matching the given id.
func (s *ProductServer) GetSimilar(ctx context.Context, req *pb.GetProductRequest) (*pb.ListProductsResponse, error) {
	log.Printf("GetSimilar called with id=%q", req.GetProductId())

	similar := make([]*pb.Product, 0, 10)
	for _, p := range mockProducts {
		if p.Id == req.GetProductId() {
			continue
		}
		similar = append(similar, p)
		if len(similar) == 10 {
			break
		}
	}

	return &pb.ListProductsResponse{Products: similar}, nil
}
