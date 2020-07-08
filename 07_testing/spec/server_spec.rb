require 'spec_helper'

require_relative "../server.rb"

RSpec.describe TestingServer do
  let(:req) { message = Testing::HelloRequest.new(name: 'World') }

  context 'with a successful connection' do
    it 'receives a message' do
      server = TestingServer.new
      reply = server.say_hello(req, {})
      expect(reply).to eq(
        Testing::HelloReply.new(message: "Hello World")
      )
    end
  end
end
