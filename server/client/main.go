package main

import (
	"context"
	"fmt"
	"log"
	"time"

	"google.golang.org/grpc"
	"google.golang.org/grpc/credentials/insecure"

	pb "fashion-grpc/proto"
)

func main() {
	conn, err := grpc.NewClient("localhost:50051", grpc.WithTransportCredentials(insecure.NewCredentials()))
	if err != nil {
		log.Fatalf("did not connect: %v", err)
	}
	defer conn.Close()

	client := pb.NewProductServiceClient(conn)

	ctx, cancel := context.WithTimeout(context.Background(), 3*time.Second)
	defer cancel()

	resp, err := client.ListProducts(ctx, &pb.ListProductsRequest{})
	if err != nil {
		log.Fatalf("ListProducts failed: %v", err)
	}

	for _, p := range resp.Products {
		fmt.Printf("%-4s %-22s %-10s %6.2f %s  sizes=%v  color=%s\n", p.Id, p.Name, p.Brand, p.Price, p.Currency, p.Sizes, p.Color)
	}
}
