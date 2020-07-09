this_dir = File.expand_path(File.dirname(__FILE__))
lib_dir = File.join(this_dir, 'lib')
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)

require 'grpc'
require 'chain_services_pb'

class AuthInterceptor < GRPC::ServerInterceptor
  def request_response(request:, call:, method:)
    auth_token = "my-special-token-x"
    jwt_token = "my-jwt-token"

    case
    when call.metadata[auth_token] then yield
    when call.metadata[jwt_token] then yield
    else
      raise GRPC::BadStatus.new_status_exception(
        GRPC::Core::StatusCodes::PERMISSION_DENIED,
        "Permission denied"
      )
    end
  end
end

class RequestValidationInterceptor < GRPC::ServerInterceptor
  def request_response(request:, call:, method:)
    match = /^[A-Za-z ]+$/i.match(request.payload)

    unless match
      raise GRPC::BadStatus.new_status_exception(
        GRPC::Core::StatusCodes::INVALID_ARGUMENT,
        "Invalid argument supplied"
      )
    end

    yield
  end
end

class ChainServer < Chain::Service
  def do_a_thing(chain_req, call)
    ThingReply.new(payload: "Received request: #{chain_req.payload}")
  end
end

def main
  s = GRPC::RpcServer.new(interceptors: [AuthInterceptor.new, RequestValidationInterceptor.new])
  s.add_http2_port(
    '0.0.0.0:50051',
    :this_port_is_insecure,
  )
  s.handle(ChainServer)

  p "Starting server on port 50051..."

  s.run_till_terminated_or_interrupted([1, 'int', 'SIGQUIT'])
end

main
