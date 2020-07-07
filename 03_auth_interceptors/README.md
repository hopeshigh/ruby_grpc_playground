# Authentication with Interceptors

## Concept

To demonstrate a simple token based authentication using gRPC.

Service definitions can be found in [./protos/auth.proto](./protos/auth.proto)

In this example we are passing static credentials as metadata attached to the client call.

We intercept this call on the server side and perform crude validation that this is a value
we expect and return the secret message.

We then try making a call without the expected credentials and return an error.

We are using an `Interceptor` on the server in order to do this, by registering the Interceptor
we are able to monkey-patch the call to `request_response` and either yield to the code call, or
raise a `GRPC::BadStatus`.

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
