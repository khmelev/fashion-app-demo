# Fashion App — mock gRPC server

A minimal gRPC service in Go that serves a fixed, in-memory catalog of fashion products to the [Flutter app](../README.md). Built as a learning reference, not a production service.

## API

Defined in [`proto/product.proto`](proto/product.proto):

| RPC | Description |
| --- | --- |
| `ListProducts` | Returns the whole catalog |
| `GetProduct` | Returns one product by id, or `NotFound` |
| `GetSimilar` | Returns up to 10 products other than the given one |

## Prerequisites

- Go 1.25 or newer
- Only for regenerating code: `protoc`, `protoc-gen-go` and `protoc-gen-go-grpc`

## Run the server

```bash
go mod tidy   # fetch dependencies
go run .
```

You should see: `gRPC server listening on :50051`

## Call it

In a second terminal, run the example client, which prints the catalog:

```bash
go run ./client
```

Or use [grpcurl](https://github.com/fullstorydev/grpcurl). The server has reflection enabled, so no `.proto` file is needed:

```bash
grpcurl -plaintext localhost:50051 fashion.ProductService/ListProducts
grpcurl -plaintext -d '{"product_id": "p1"}' localhost:50051 fashion.ProductService/GetProduct
grpcurl -plaintext -d '{"product_id": "p1"}' localhost:50051 fashion.ProductService/GetSimilar
```

## Regenerate code from the proto

Only needed if you change `proto/product.proto` — the generated files are checked in.

One-time setup:

```bash
go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest
# make sure $(go env GOPATH)/bin is on your PATH
```

Then:

```bash
protoc --go_out=. --go_opt=paths=source_relative \
  --go-grpc_out=. --go-grpc_opt=paths=source_relative \
  proto/product.proto
```

The Flutter app keeps an identical copy of the proto in `../app/proto/`. Update it too and regenerate the Dart client, as described in the [project README](../README.md#api).

## License

Released under the [MIT License](../LICENSE).
