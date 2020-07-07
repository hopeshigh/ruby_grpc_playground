this_dir = File.expand_path(File.dirname(__FILE__))
lib_dir = File.join(this_dir, 'lib')
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)

require 'grpc'
require 'using_json_services_pb'

class JsonServer < UsingJsonService::Service
  def create_user(user_req, _unused_call)
    UserResponse.new(
      message: "User created for: #{user_req.data.email}",
      created: 1
    )
  end

  def create_multiple_users(user_requests, _unused_call)
    user_responses = user_requests.users.map do |user|
      UserResponse.new(
        message: "User created for: #{user.email}",
        created: 1
      )
    end

    UserResponses.new(response: user_responses)
  end
end

def main
  s = GRPC::RpcServer.new
  s.add_http2_port('0.0.0.0:50051', :this_port_is_insecure)
  s.handle(JsonServer)

  p "Starting server on port 50051..."

  s.run_till_terminated_or_interrupted([1, 'int', 'SIGQUIT'])
end

main
