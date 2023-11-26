# Information
The `api` directory contains handlers like `api_handler.dart`, `auth_handler.dart`, and `user_handler.dart` which are responsible for handling API calls related to different functionalities of the application. The `gocast` and `google` directories contain protobuf files generated from the `.proto` files which are used for serializing structured data.

The `api/gocast` directory contains protobuf files for the GoCast API, and the `api/google` directory contains protobuf files for Google's well-known types. These protobuf files are used by the `grpc_handler.dart` to make API calls._


> __NOTE__: _Currently using HTTP for the login, but ideally all other endpoints are called using gRPC. To get an idea how this looks like and what the endpoint definitions are check out our ***[Postman Collection](https://documenter.getpostman.com/view/31343920/2s9YeBdszX)*** and out current ***[protofile](https://github.com/TUM-Dev/gocast/blob/IPraktikum-dev/api_v2/api_v2.proto)***._

# Setup

To setup the protobuf files, follow the steps below:

Make sure to have protoc installed:

```
brew install grpc protobuf
```

```
dart pub global activate protoc_plugin
export PATH="$PATH:$HOME/.pub-cache/bin"
curl -o proto/gocast/api_v2.proto https://raw.githubusercontent.com/TUM-Dev/gocast/IPraktikum-36-user-endpoints/api_v2/api_v2.proto
protoc --dart_out=grpc:lib/base/networking/api -I./proto google/protobuf/timestamp.proto google/protobuf/empty.proto proto/gocast/api_v2.proto 
```

> __Source__: https://github.com/TUM-Dev/Campus-Flutter#updating-the-proto-files-of-the  