this_dir = File.expand_path(File.dirname(__FILE__))
lib_dir = File.join(this_dir, 'lib')
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)

require 'grpc'
require 'auth_services_pb'

class AuthInterceptor < GRPC::ServerInterceptor
  def request_response(request:, call:, method:)
    expected_token = call.metadata["my-special-token-x"]

    if expected_token.nil?
      raise GRPC::BadStatus.new_status_exception(GRPC::Core::StatusCodes::PERMISSION_DENIED)
    end
    yield
  end
end

class AuthServer < Auth::Service
  def secret_thing(auth_req, _unused_call)
    AuthReply.new(message: "Received request: #{auth_req.payload}")
  end
end

def main
  s = GRPC::RpcServer.new( interceptors: [AuthInterceptor.new])
  s.add_http2_port(
    '0.0.0.0:50051',
    :this_port_is_insecure,
  )
  s.handle(AuthServer)

  p "Starting server on port 50051..."

  s.run_till_terminated_or_interrupted([1, 'int', 'SIGQUIT'])
end

main
