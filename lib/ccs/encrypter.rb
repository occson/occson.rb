# frozen_string_literal: true

module Ccs
  class Encrypter
    def initialize(passphrase, content, salt)
      @passphrase = passphrase
      @content = content
      @salt = salt
    end

    def call
      encryptor.pkcs5_keyivgen(@passphrase, @salt, 1)
      encrypted = encryptor.update(@content)
      encrypted << encryptor.final

      openssl_salted_ciphertext = 'Salted__' + @salt + encrypted
      Base64.strict_encode64(openssl_salted_ciphertext)
    end

    private

    def encryptor
      @encryptor ||= OpenSSL::Cipher::AES.new(256, :CBC).encrypt
    end
  end
end
