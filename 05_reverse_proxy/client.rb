this_dir = File.expand_path(File.dirname(__FILE__))
lib_dir = File.join(this_dir, 'lib')
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)

require 'grpc'
require 'reverse_services_pb'
require 'securerandom'

def main
  value = SecureRandom.uuid
  hostname = 'localhost:51051'
  stub = Reverse::Stub.new(hostname, :this_channel_is_insecure)

  begin
    response = stub.echo(Message.new(value: value)).value
    p "Reponse: #{response}"

    pong = stub.ping(Message.new(value: value)).value
    p "Pong Reponse: #{pong}"
  rescue GRPC::BadStatus => e
    abort "ERROR: #{e.message}"
  end
end

main
