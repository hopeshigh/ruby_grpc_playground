this_dir = File.expand_path(File.dirname(__FILE__))
lib_dir = File.join(this_dir, 'lib')
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)

require 'grpc'
require 'testing_services_pb'

class Client
  def initialize(stub = Testing::Greeter::Stub.new('localhost:50051', :this_channel_is_insecure))
    @stub = stub
  end

  def say_hello(input)
    message = Testing::HelloRequest.new(name: input)
    @stub.say_hello(message).message
  end
end

