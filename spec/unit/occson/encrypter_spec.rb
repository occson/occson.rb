# frozen_string_literal: true

RSpec.describe Occson::Encrypter do
  let(:encrypter) { described_class.new passphrase, content, salt }

  subject { encrypter }

  describe '#call' do
    let(:passphrase) { 'passphrase' }
    let(:content) { 'content' }
    let(:salt) { 'secret_t' }

    it { expect(subject.call).to eq 'U2FsdGVkX19zZWNyZXRfdDngaQw8zQbHado/FhnBIsQ=' }
  end
end
