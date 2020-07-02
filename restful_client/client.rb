this_dir = File.expand_path(File.dirname(__FILE__))
lib_dir = File.join(this_dir, 'lib')
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)

require 'securerandom'

require 'grpc_web'
require 'grpc_web/client/client'
require 'rest_services_pb'

def main
 value = SecureRandom.uuid

  hostname = 'http://localhost:8080'
  client = GRPCWeb::Client.new(
    hostname,
    Rest::Service,
  )
  begin
     value = client.echo(
       value: value
     ).value

    p "Response: #{value}"
  rescue GRPC::BadStatus => e
    abort "ERROR: #{e.inspect}"
  end
end

main
