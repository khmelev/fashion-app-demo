# Fashion App

A simple fashion e-commerce demo: a Flutter app for Android and iOS, backed by a small mock gRPC server written in Go. Built for educational purposes.

![Flutter](https://img.shields.io/badge/Flutter-02569B?logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?logo=dart&logoColor=white)
![Go](https://img.shields.io/badge/Go-00ADD8?logo=go&logoColor=white)
![gRPC](https://img.shields.io/badge/gRPC-244C5A)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

## Features

- **Catalog** — a product grid with skeleton loading and a retry screen on errors
- **Product details** — size selection, add to cart, and a strip of similar products
- **Cart** — animated list with quantity controls
- **Profile** — mock login and logout
- **Light and dark themes**
- **Two data sources** — the Go gRPC backend, or in-memory fake data that needs no backend

Everything is mocked: product data is hardcoded, products are shown as colour swatches instead of photos, the cart lives in memory, and login accepts any non-empty email and password.

## Tech stack

| Part | Technology |
| --- | --- |
| App | [Flutter](https://flutter.dev), [Riverpod](https://riverpod.dev) for state and dependency injection, [go_router](https://pub.dev/packages/go_router) for navigation |
| Backend | [Go](https://go.dev), [gRPC](https://grpc.io) |
| API contract | Protocol Buffers |

## Project structure

```
app/       Flutter app
  lib/
    data/        services (gRPC and local fake) and repositories (Riverpod providers)
    domain/      models
    ui/          screens, grouped by feature
    routing/     go_router configuration
    generated/   Dart gRPC client generated from the proto
  proto/         API contract (copy of server/proto)
server/    Mock gRPC backend in Go
```

## Getting started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) with Dart 3.12 or newer
- [Go](https://go.dev/dl/) 1.25 or newer — only needed to run the backend
- An iOS simulator or Android emulator

### Run the app without a backend

The development entry point serves in-memory fake data, so this is the quickest way to try the app:

```bash
cd app
flutter pub get
flutter run -t lib/main_development.dart
```

### Run the app against the gRPC server

Start the server:

```bash
cd server
go run .
```

Then, in a second terminal, run the app:

```bash
cd app
flutter run
```

The app connects to `localhost:50051`. This works on the iOS simulator. An Android emulator cannot reach the host machine through `localhost`, so change the host in `app/lib/data/services/shop_service_remote.dart` to `10.0.2.2`.

See [server/README.md](server/README.md) for more on the backend.

## API

The contract is defined in [`server/proto/product.proto`](server/proto/product.proto), with an identical copy in `app/proto/`.

| RPC | Description |
| --- | --- |
| `ListProducts` | Returns the whole catalog |
| `GetProduct` | Returns one product by id |
| `GetSimilar` | Returns up to 10 products other than the given one |

If you change the proto, update both copies and regenerate the code on both sides:

```bash
# Go, from server/
protoc --go_out=. --go_opt=paths=source_relative \
  --go-grpc_out=. --go-grpc_opt=paths=source_relative \
  proto/product.proto

# Dart, from app/ (requires: dart pub global activate protoc_plugin)
protoc --dart_out=grpc:lib/generated -Iproto proto/product.proto
```

## License

Released under the [MIT License](LICENSE).
