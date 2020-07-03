# Using GRPCWeb

## Concept

To demonstrate using [GRPCWeb](https://github.com/gusto/grpc-web-ruby).

Service definitions can be found in [./protos/web.proto](./protos/web.proto)

This sets up a Rack server that will be able to handle requests coming from
Ruby webclients as well as Javascript based clients that are using gRPC over HTTP/1.

## Instructions

* Compile our protobuf service definitions and generate our Ruby definitions

```shell
make
```

* Run the server in one terminal:

```ruby
ruby server.rb
```

* Run the client in another terminal:

```ruby
ruby client.rb
```

* Receive a response and celebrate
