
.PHONY: all

all: compile

compile:
	@bundle exec grpc_tools_ruby_protoc -I ./protos --ruby_out=./lib --grpc_out=./lib ./protos/slightly_more_complex.proto

clean:
	@rm -rf ./lib && mkdir lib
