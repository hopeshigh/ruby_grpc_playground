GOOGLEAPIS_DIR=./google-vendor-protos

.PHONY: all

all: compile

compile: descriptor
	@bundle exec grpc_tools_ruby_protoc -I ./protos -I $(GOOGLEAPIS_DIR) --ruby_out=./lib --grpc_out=./lib ./protos/*.proto

descriptor:
	@bundle exec grpc_tools_ruby_protoc -I ./protos -I $(GOOGLEAPIS_DIR) --include_imports --include_source_info \
--descriptor_set_out=./lib/proto.pb ./protos/*.proto

clean:
	@rm ./lib/*
