this_dir = File.expand_path(File.dirname(__FILE__))
lib_dir = File.join(this_dir, 'lib')
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)

require 'securerandom'

require 'grpc'
require 'chain_services_pb'

class Client
  def initialize(hostname, metadata = {})
    @stub = Chain::Stub.new(hostname, :this_channel_is_insecure)
    @metadata = metadata
  end

  def do_a_thing(payload)
    begin
      response = @stub.do_a_thing(ThingRequest.new(payload: payload), metadata: @metadata)
      response.payload
    rescue GRPC::BadStatus => e
      puts "ERROR: #{e.code}"
      puts "ERROR: #{e.details}"
    end
  end
end

token = SecureRandom.uuid
custom_api_token = {
  'my-special-token-x': token
}

jwt_token = {
  'my-jwt-token': token
}

hostname = 'localhost:50051'

client1 = Client.new(hostname, custom_api_token)
client2 = Client.new(hostname, jwt_token)
client3 = Client.new(hostname)

puts client1.do_a_thing("secret words")

puts client2.do_a_thing("th1s will fail due invalid payload")

puts client3.do_a_thing("this will fail due to no auth token")

