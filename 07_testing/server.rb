this_dir = File.expand_path(File.dirname(__FILE__))
lib_dir = File.join(this_dir, 'lib')
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)

require 'grpc'
require 'testing_services_pb'

class TestingServer < Testing::Greeter::Service
  def say_hello(hello_req, _unused_call)
    Testing::HelloReply.new(message: "Hello #{hello_req.name}")
  end
end

