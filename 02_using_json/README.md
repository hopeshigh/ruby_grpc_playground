# Using JSON

## Concept

To demonstrate how to define and create a Message using a JSON blob.

Service definitions can be found in [./protos/using_json.proto](./protos/using_json.proto)

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
