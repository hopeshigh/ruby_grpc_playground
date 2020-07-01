this_dir = File.expand_path(File.dirname(__FILE__))
lib_dir = File.join(this_dir, 'lib')
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)

require 'securerandom'

require 'grpc'
require 'auth_services_pb'

def main
 token = SecureRandom.uuid
  custom_api_token = {
    'my-special-token-x': token
  }

  hostname = 'localhost:50051'
  stub = Auth::Stub.new(
    hostname,
    :this_channel_is_insecure,
  )
  begin
     message = stub.secret_thing(
       AuthRequest.new(payload: "secret words"),
       metadata: custom_api_token
     ).message

    p "Response: #{message}"
  rescue GRPC::BadStatus => e
    abort "ERROR: #{e.inspect}"
  end
end

main
