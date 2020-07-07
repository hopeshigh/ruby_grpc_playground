this_dir = File.expand_path(File.dirname(__FILE__))
lib_dir = File.join(this_dir, 'lib')
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)

require 'grpc'
require 'using_json_services_pb'

def main
  single_json_input = {
    name: "Testing McTestface",
    email: "test@test.com",
    age: 12
  }
  multiple_json_input = [
    {
    name: "Testing McTestface",
    email: "test@test.com",
    age: 12
    },
    {
    name: "Testing McTestface",
    email: "test1@testingisfun.com",
    age: 21
    },
  ]

  hostname = 'localhost:50051'
  stub = UsingJsonService::Stub.new(hostname, :this_channel_is_insecure)
  begin
    result = stub.create_user(UserRequest.new(
      data: single_json_input
    )).message
    p "Result: #{result}"

  multiple_requests = multiple_json_input.map do |input|
    User.new(input)
  end

  multi_result = stub.create_multiple_users(UserRequests.new(
      users: multiple_requests
  )).response
    p "Multi Result: #{multi_result}"

  rescue GRPC::BadStatus => e
    abort "ERROR: #{e.message}"
  end
end

main
