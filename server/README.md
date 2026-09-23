# fashion-grpc

A minimal, working gRPC service in Go that returns a fixed catalog of
fashion products. Built as a learning reference — see the full
walkthrough in chat for explanations of each piece.

## Prerequisites

- Go 1.22+
- protoc (Protocol Buffer compiler)
- protoc-gen-go and protoc-gen-go-grpc (installed via `go install`, see below)

## One-time setup

```bash
go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest
# make sure $(go env GOPATH)/bin is on your PATH
```

## Fetch dependencies

```bash
go mod tidy
```

## (Re)generate code from the .proto file

Only needed if you change proto/product.proto — the generated files
are already included.

```bash
protoc --go_out=. --go_opt=paths=source_relative \
  --go-grpc_out=. --go-grpc_opt=paths=source_relative \
  proto/product.proto
```

## Run the server

```bash
go run .
```

You should see: `gRPC server listening on :50051`

## Call it

In a second terminal:

```bash
go run ./client
```

Or with [grpcurl](https://github.com/fullstorydev/grpcurl) (no .proto needed, thanks to reflection):

```bash
grpcurl -plaintext localhost:50051 fashion.ProductService/ListProducts
```

## Debug in VS Code

Open this folder in VS Code, set a breakpoint in `server/server.go`
inside `ListProducts`, press F5 (uses the included `.vscode/launch.json`),
then run the client in a terminal to trigger it.
