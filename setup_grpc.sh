#!/bin/bash

# Stop the script if any command fails
set -e

# Activate the protoc_plugin globally
dart pub global activate protoc_plugin

# Add Dart's package cache bin directory to the PATH
export PATH="$PATH:$HOME/.pub-cache/bin"

# Create a directory for the proto files if it doesn't exist
mkdir -p proto/gocast

# Download the api_v2.proto file
# TODO: Replace with actual proto file on dev branch once api/v2 is implemented
curl -o proto/gocast/api_v2.proto https://raw.githubusercontent.com/TUM-Dev/gocast/IPraktikum-dev/api_v2/api_v2.proto

# Run the protoc command to generate Dart gRPC code
protoc --dart_out=grpc:lib/base/networking/api -I./proto google/protobuf/timestamp.proto google/protobuf/empty.proto proto/gocast/api_v2.proto

echo "gRPC code generation completed successfully."