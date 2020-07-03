this_dir = File.expand_path(File.dirname(__FILE__))
lib_dir = File.join(this_dir, 'lib')
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)

require 'grpc'
require 'slightly_more_complex_services_pb'

def main
  user = ARGV.size > 0 ?  ARGV[0] : 'Fred'
  age = ARGV.size > 1 ?  ARGV[1].to_i : 99
  email = "test@test.com"
  hostname = 'localhost:50051'
  stub = Slightlymorecomplex::UserService::Stub.new(hostname, :this_channel_is_insecure)
  begin
    result = stub.create_user(Slightlymorecomplex::UserRequest.new(
      data: {
        name: user,
        email: email,
        age: age
      }
    )).message
    p "Result: #{result}"
  rescue GRPC::BadStatus => e
    abort "ERROR: #{e.message}"
  end
end

main
