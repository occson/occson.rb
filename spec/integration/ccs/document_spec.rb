# frozen_string_literal: true

RSpec.describe Ccs::Document do
  let(:document) { described_class.new uri, access_token, passphrase }

  subject { document }

  let(:access_token) { 'access_token' }
  let(:passphrase) { 'passphrase' }
  let(:uri) { 'ccs://a/b/c.txt' }

  before do
    stub_request(:get, 'https://api.occson.com/a/b/c.txt')
      .to_return(status: 200,
                 body: { encrypted_content: 'U2FsdGVkX19zZWNyZXRfdDngaQw8zQbHado/FhnBIsQ=' }.to_json,
                 headers: { 'Content-Type' => 'application/json' })
    stub_request(:post, 'https://api.occson.com/a/b/c.txt')
      .to_return(status: 201,
                 body: { encrypted_content: 'U2FsdGVkX19zZWNyZXRfdDngaQw8zQbHado/FhnBIsQ=' }.to_json,
                 headers: { 'Content-Type' => 'application/json' })
    stub_request(:post, 'https://api.occson.com/a/b/c.txt')
      .with(body: a_string_including('"force":"true"'))
      .to_return(status: 200,
                 body: { encrypted_content: 'U2FsdGVkX19zZWNyZXRfdDngaQw8zQbHado/FhnBIsQ=' }.to_json,
                 headers: { 'Content-Type' => 'application/json' })
  end

  describe '#upload' do
    context 'with ccs scheme' do
      it { expect(subject.upload('content')).to eq true }
    end

    context 'with ccs scheme and force' do
      it { expect(subject.upload('content', force: true)).to eq true }
    end
  end

  describe '#download' do
    context 'with ccs scheme' do
      it { expect(subject.download).to eq 'content' }
    end
  end
end
