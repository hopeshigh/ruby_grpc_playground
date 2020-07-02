this_dir = File.expand_path(File.dirname(__FILE__))
lib_dir = File.join(this_dir, 'lib')
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)


require 'http_services_pb'
require 'httparty'

def main
  hostname = 'http://localhost:4567'
  response = HTTParty.get(hostname)

  p "Receiving response...."

  p response

  p "Decoding response..."

  dem = EchoMessage.decode(response.parsed_response)

  p "Received: #{dem}"
end

main
