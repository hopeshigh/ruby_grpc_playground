#  Chaining Interceptors

## Concept

To demonstrate chaining interceptors with gRPC.

Service definitions can be found in [./protos/chain.proto](./protos/chain.proto)

In this example we are chaining interceptors for a client call, Interceptors are handled in a FIFO manner

We are using an `Interceptor` on the server in order to do this, by registering the Interceptor
we are able to monkey-patch the call to `request_response` and either yield to the code call, or
raise a `GRPC::BadStatus`.

**NOTE**:

Changes to metadata or the call in one interceptor will not propogate to another. This is due to how
the underlying Ruby gRPC code is implemented.

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
