this_dir = File.expand_path(File.dirname(__FILE__))
lib_dir = File.join(this_dir, 'lib')
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)

require 'grpc_web'
require 'rest_services_pb'
require 'rack/handler'

class RestServer < Rest::Service
  def echo(echo_req)
    p echo_req
    EchoMessage.new(value: echo_req.value)
  end
end

def main
  GRPCWeb.handle(RestServer)
  Rack::Handler::WEBrick.run GRPCWeb.rack_app

end

main
