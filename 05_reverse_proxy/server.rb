this_dir = File.expand_path(File.dirname(__FILE__))
lib_dir = File.join(this_dir, 'lib')
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)

require 'grpc'
require 'reverse_services_pb'

class ReverseServer < Reverse::Service
  def echo(reverse_req, unused_call)
    Message.new(value: "#{reverse_req.value}")
  end

  def ping(reverse_req, unused_call)
    Message.new(value: "PONG VALUE")
  end
end

class AnotherServer < Another::Service
  def echo(another_req, unused_call)
    Message.new(value: "#{another_req.value}")
  end

  def ping(another_req, unused_call)
    Message.new(value: "PONG VALUE")
  end
end

def main
  s = GRPC::RpcServer.new
  s.add_http2_port('0.0.0.0:50051', :this_port_is_insecure)
  s.handle(ReverseServer)
  s.handle(AnotherServer)

  p "Starting server on port 50051..."

  s.run_till_terminated_or_interrupted([1, 'int', 'SIGQUIT'])
end

main
