# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

A minimal, working gRPC service in Go that returns a fixed (hardcoded, in-memory)
catalog of fashion products. Built as a learning reference, not a production service.

## Commands

```bash
# Fetch dependencies
go mod tidy

# Run the server (listens on :50051)
go run .

# Run the client (in a second terminal, talks to the running server)
go run ./client

# Or call it without the client, via reflection (no .proto needed)
grpcurl -plaintext localhost:50051 fashion.ProductService/ListProducts

# Build
go build ./...
```

There is no test suite in this repo yet.

### Regenerating protobuf code

Only needed after editing `proto/product.proto` — the generated `.pb.go` files
are already checked in. Requires `protoc` plus `protoc-gen-go` and
`protoc-gen-go-grpc` (`go install google.golang.org/protobuf/cmd/protoc-gen-go@latest`
and `go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest`, with
`$(go env GOPATH)/bin` on `PATH`):

```bash
protoc --go_out=. --go_opt=paths=source_relative \
  --go-grpc_out=. --go-grpc_opt=paths=source_relative \
  proto/product.proto
```

## Architecture

- `proto/product.proto` — single source of truth for the `ProductService` API
  (currently one RPC: `ListProducts`). `proto/product.pb.go` and
  `proto/product_grpc.pb.go` are generated from it — never hand-edit these,
  regenerate instead.
- `server/server.go` — `ProductServer` implements the generated
  `pb.ProductServiceServer` interface by embedding
  `pb.UnimplementedProductServiceServer` (so future RPCs added to the proto
  don't break compilation until implemented). `ListProducts` returns a
  hardcoded product slice; there is no database.
- `main.go` — wires everything together: opens a TCP listener on `:50051`,
  registers `ProductServer` with a `grpc.NewServer()`, and registers gRPC
  reflection so tools like `grpcurl`/Postman can introspect the service
  without the `.proto` file.
- `client/main.go` — standalone example client (separate `main` package)
  that dials `localhost:50051` with insecure credentials and calls
  `ListProducts`.

Adding a new RPC means: edit `proto/product.proto`, regenerate, implement the
new method on `ProductServer` in `server/server.go`.
