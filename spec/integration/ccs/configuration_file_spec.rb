# frozen_string_literal: true

RSpec.describe Ccs::ConfigurationFile do
  let(:configuration_file) { described_class.new uri, access_token, secret_token }

  subject { configuration_file }

  let(:access_token) { 'access_token' }
  let(:secret_token) { 'secret_token' }
  let(:uri) { 'ccs://a/b/c.txt' }

  before do
    stub_request(:get, 'http://api.occson.com:443/a/b/c.txt')
      .to_return(status: 200,
                 body: { message: 'OK', status: '200',
                         encrypted_content: 'U2FsdGVkX19zZWNyZXRfdAysfeMlKF4wGAULx3axRnM=' }.to_json,
                 headers: { 'Content-Type' => 'application/json' })
    stub_request(:post, 'http://api.occson.com:443/a/b/c.txt')
      .to_return(status: 201,
                 body: { message: 'Created', status: '201' }.to_json,
                 headers: { 'Content-Type' => 'application/json' })
  end

  describe '#upload' do
    context 'with ccs scheme' do
      it { expect(subject.upload('content')).to eq true }
    end
  end

  describe '#download' do
    context 'with ccs scheme' do
      it { expect(subject.download).to eq 'content' }
    end
  end
end
