> __NOTE__: _This directory contains all handlers used to fetch/send data from/to the remote APIs. Currently using HTTP for the login, but ideally all other endpoints are called using gRPC. To get an idea how this looks like and what the endpoint definitions are check out our ***[Postman Collection](https://documenter.getpostman.com/view/31343920/2s9YeBdszX)*** and out current ***[protofile](https://github.com/TUM-Dev/gocast/blob/IPraktikum-dev/api_v2/api_v2.proto)***._

```
dart pub global activate protoc_plugin
export PATH="$PATH:$HOME/.pub-cache/bin"
curl -o proto/gocast/api_v2.proto https://raw.githubusercontent.com/TUM-Dev/gocast/IPraktikum-36-user-endpoints/api_v2/api_v2.proto
protoc --dart_out=grpc:lib/base/networking/api -I./proto google/protobuf/timestamp.proto google/protobuf/empty.proto proto/gocast/api_v2.proto 
```