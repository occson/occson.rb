# frozen_string_literal: true

RSpec.describe Ccs::Decrypter do
  let(:decrypter) { described_class.new passphrase, content }

  subject { decrypter }

  describe '#call' do
    let(:passphrase) { 'secret_token' }
    let(:content) { 'U2FsdGVkX19zZWNyZXRfdAysfeMlKF4wGAULx3axRnM=' }

    it { expect(subject.call).to eq 'content' }
  end
end
