# Hello World

## Concept

To demonstrate a simple `Hello, World` using gRPC.

Service definitions can be found in [./protos/hello_world.proto](./protos/hello_world.proto)

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
