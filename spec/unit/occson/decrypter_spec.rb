# frozen_string_literal: true

RSpec.describe Occson::Decrypter do
  let(:decrypter) { described_class.new passphrase, content }

  subject { decrypter }

  describe '#call' do
    let(:passphrase) { 'passphrase' }
    let(:content) { 'U2FsdGVkX19zZWNyZXRfdDngaQw8zQbHado/FhnBIsQ=' }

    it { expect(subject.call).to eq 'content' }
  end
end
