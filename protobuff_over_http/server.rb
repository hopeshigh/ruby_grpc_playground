this_dir = File.expand_path(File.dirname(__FILE__))
lib_dir = File.join(this_dir, 'lib')
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)

require 'securerandom'

require 'http_services_pb'
require 'sinatra'

get '/' do
  value = SecureRandom.uuid
  em = EchoMessage.new(value: value)
  EchoMessage.encode(em)
end
