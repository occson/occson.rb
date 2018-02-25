# frozen_string_literal: true

RSpec.describe Ccs::Encrypter do
  let(:encrypter) { described_class.new passphrase, content, salt }

  subject { encrypter }

  describe '#call' do
    let(:passphrase) { 'secret_token' }
    let(:content) { 'content' }
    let(:salt) { 'secret_t' }

    it { expect(subject.call).to eq 'U2FsdGVkX19zZWNyZXRfdAysfeMlKF4wGAULx3axRnM=' }
  end
end
