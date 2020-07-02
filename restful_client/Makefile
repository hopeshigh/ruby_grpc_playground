
.PHONY: all

all: compile

compile:
	@bundle exec grpc_tools_ruby_protoc --proto_path=./google-vendor-protos -I ./protos --ruby_out=./lib --grpc_out=./lib ./protos/rest.proto

clean:
	@rm -rf ./lib && mkdir lib
