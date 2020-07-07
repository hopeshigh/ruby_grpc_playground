# Slightly More Complex

## Concept

To demonstrate a slightly more complex example using gRPC.

Service definitions can be found in [./protos/slightly_more_complex.proto](./protos/slightly_more_complex.proto)

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
