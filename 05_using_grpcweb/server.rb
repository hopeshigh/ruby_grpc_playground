this_dir = File.expand_path(File.dirname(__FILE__))
lib_dir = File.join(this_dir, 'lib')
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)

require 'grpc_web'
require 'web_services_pb'
require 'rack/handler'

class WebServer < Web::Service
  def echo(echo_req)
    p echo_req
    EchoMessage.new(value: echo_req.value)
  end
end

def main
  GRPCWeb.handle(WebServer)
  Rack::Handler::WEBrick.run GRPCWeb.rack_app
end

main
