# Protobuf over HTTP/1

## Concept

To demonstrate using protobuf over HTTP/1.

Service definitions can be found in [./protos/http.proto](./protos/http.proto)

This uses a barebones [Sinatra](http://sinatrarb.com/) app to demonstrate how to use
protobuf over HTTP/1. 

This is possible because the generated Ruby code adds two methods onto a `message` defined in
your service definition file. These are `.encode/1` and `.decode/1`.

They will try to encode and decode the values provided to fit the shape of the defined message.

We can then pass these over HTTP/1 in the same manner as we would with JSON / another encoding.

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
