# frozen_string_literal: true

RSpec.describe Ccs::Application do
  let(:application) { described_class.new source, destination, access_token, secret_token }

  subject { application }

  let(:access_token) { 'access_token' }
  let(:secret_token) { 'secret_token' }

  before do
    stub_request(:get, 'http://example.com/a/b/c.txt')
      .to_return(status: 200,
                 body: { message: 'OK', status: '200',
                         encrypted_content: 'U2FsdGVkX19zZWNyZXRfdAysfeMlKF4wGAULx3axRnM=' }.to_json,
                 headers: { 'Content-Type' => 'application/json' })
    stub_request(:post, 'http://example.com/a/b/c.txt')
      .to_return(status: 201,
                 body: { message: 'Created', status: '201' }.to_json,
                 headers: { 'Content-Type' => 'application/json' })
  end

  describe '#run' do
    context 'when downloads' do
      let(:source) { 'http://example.com/a/b/c.txt' }

      context 'to STDOUT' do
        let(:destination) { '-' }

        it { expect { subject.run }.to output('content').to_stdout_from_any_process }
      end

      context 'to file' do
        let(:io) { StringIO.new }
        let(:destination) { 'tmp/fake_file.txt' }

        before { allow(File).to receive(:new).and_return(io) }

        it 'prints content to file' do
          expect(subject.run).to eq nil
          io.rewind
          expect(io.read).to eq 'content'
        end
      end
    end

    context 'when uploads' do
      let(:destination) { 'http://example.com/a/b/c.txt' }

      context 'from STDIN' do
        before { STDIN = StringIO.new('content') }
        let(:source) { '-' }

        it { expect(subject.run).to eq true }
      end

      context 'from file' do
        let(:source) { 'spec/fixtures/fake_file.txt' }

        it { expect(subject.run).to eq true }
      end
    end
  end
end
