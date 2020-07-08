require 'spec_helper'

require_relative "../client.rb"

RSpec.describe Client do
  let(:server_host) { '0.0.0.0:0' }
  let(:stub) { instance_double(Testing::Greeter::Stub) }
  let(:input) { "World" }
  let(:output) { "Hello World" }
  let(:req_message) { Testing::HelloRequest.new(name: input) }
  let(:resp_message) { Testing::HelloReply.new(message: output) }

  context 'with a successful connection' do
    it 'sends a message' do
      expect(stub).to receive(:say_hello).with(req_message).and_return(resp_message)

      client = Client.new(stub)
      response = client.say_hello(input)

      expect(response).to eq("Hello World")
    end
  end
end
