# JSON transcoding via Envoy reverse proxy

## Concept

This uses [Envoy](https://www.envoyproxy.io/) to build a proxy that will map HTTP requests 
to the corresponding gRPC server and attempt to execute the request.

It will also allow you to use a gRPC client as normal.

Service definitions can be found in [./protos/web.proto](./protos/web.proto)

This also adds our first set of options to our service definition as well as having
to vendor the implementation within the repo.

It also adds an additional step within our [Makefile](./Makefile) to generate the
neccessary `file descriptors` that Envoy will use to generate the mapping in our proxy.


## Instructions

* Compile our protobuf service definitions and generate our Ruby definitions

```shell
make
```

* Build our envoy container

```shell
docker build -t envoy:v1 . 
```

* Run our envoy container as a daemon

```shell
docker run -d --name envoy -p 9901:9901 -p 51051:51051 envoy:v1
```

* Run the server in one terminal:

```shell
ruby server.rb
```

* Post a JSON request to the running `echo` server

```shell
curl -X POST localhost:51051/another/echo \
-d '{ "value": "This should work" }'
```

* Send a GET request to the running `echo` server

```shell
curl -X GET localhost:51051/revserse/ping 
```

* Post a gRPC request to the running `echo` server

```shell
ruby client.rb
```
