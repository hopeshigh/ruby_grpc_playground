this_dir = File.expand_path(File.dirname(__FILE__))
lib_dir = File.join(this_dir, 'lib')
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)

require 'grpc'
require 'slightly_more_complex_services_pb'

class UserServer < Slightlymorecomplex::UserService::Service
  def create_user(user_req, _unused_call)
    p "Doing some complex work creating a user"

    Slightlymorecomplex::UserResponse.new(
      message: "User created for: #{user_req.data.email}",
      created: 1
    )
  end
end

def main
  s = GRPC::RpcServer.new
  s.add_http2_port('0.0.0.0:50051', :this_port_is_insecure)
  s.handle(UserServer)

  s.run_till_terminated_or_interrupted([1, 'int', 'SIGQUIT'])
end

main
