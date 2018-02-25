# frozen_string_literal: true

RSpec.describe Ccs::Uploader do
  let(:uploader) { described_class.new uri, content, access_token, secret_token }

  subject { uploader }

  before do
    stub_request(:post, 'http://example.com/a/b/c.yml')
      .to_return(status: 201,
                 body: { message: 'Created', status: '201' }.to_json,
                 headers: { 'Content-Type' => 'application/json' })
    stub_request(:post, 'http://example.com/a/b/c.yml')
      .with(headers: { 'Authorization' => 'Token token=open_token' })
      .to_return(status: 401,
                 body: { message: 'Unauthorized', status: '401' }.to_json,
                 headers: { 'Content-Type' => 'application/json' })
    stub_request(:post, 'http://example.com/a/b/d.yml')
      .to_return(status: 409,
                 body: { message: 'Conflict', status: '409' }.to_json,
                 headers: { 'Content-Type' => 'application/json' })
  end

  describe '#call' do
    let(:uri) { URI 'http://example.com/a/b/c.yml' }
    let(:content) { 'content' }
    let(:access_token) { 'access_token' }
    let(:secret_token) { 'secret_token' }

    it { expect(subject.call).to eq true }

    context 'when access_token is invalid' do
      let(:access_token) { 'open_token' }

      it { expect(subject.call).to eq false }
    end

    context 'when configuration file exist' do
      let(:uri) { URI 'http://example.com/a/b/d.yml' }

      it { expect(subject.call).to eq false }
    end
  end
end
