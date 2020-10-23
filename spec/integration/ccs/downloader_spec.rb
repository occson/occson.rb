# frozen_string_literal: true

RSpec.describe Ccs::Downloader do
  let(:downloader) { described_class.new uri, access_token, passphrase }

  subject { downloader }

  before do
    stub_request(:get, 'http://example.com/a/b/c.yml')
      .to_return(status: 200,
                 body: { message: 'OK',
                         status: '200',
                         encrypted_content: 'U2FsdGVkX19zZWNyZXRfdDngaQw8zQbHado/FhnBIsQ=' }.to_json,
                 headers: { 'Content-Type' => 'application/json' })
    stub_request(:get, 'http://example.com/a/b/c.yml')
      .with(headers: { 'Authorization' => 'Token token=open_token' })
      .to_return(status: 401,
                 body: { message: 'Unauthorized', status: '401' }.to_json,
                 headers: { 'Content-Type' => 'application/json' })
    stub_request(:get, 'http://example.com/a/b/d.yml')
      .to_return(status: 404,
                 body: { message: 'Not Found', status: '404' }.to_json,
                 headers: { 'Content-Type' => 'application/json' })
  end

  describe '#call' do
    let(:uri) { URI 'http://example.com/a/b/c.yml' }
    let(:access_token) { 'access_token' }
    let(:passphrase) { 'passphrase' }

    it { expect(subject.call).to eq 'content' }

    context 'when access_token is invalid' do
      let(:access_token) { 'open_token' }

      it { expect(subject.call).to eq nil }
    end

    context 'when configuration file does not exist' do
      let(:uri) { URI 'http://example.com/a/b/d.yml' }

      it { expect(subject.call).to eq nil }
    end
  end
end
