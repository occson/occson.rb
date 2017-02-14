module Ccs
  class Decrypter
    def initialize(passphrase, content)
      @passphrase = passphrase
      @content = content
    end

    def decrypt
      decryptor.pkcs5_keyivgen(@passphrase, ciphertext_salt, 1)
      result = decryptor.update(encrypted)
      result << decryptor.final
    end

    private

    def decryptor
      @decryptor ||= OpenSSL::Cipher::AES.new(256, :CBC).decrypt
    end

    def openssl_salted_ciphertext
      @openssl_salted_ciphertext ||= Base64.strict_decode64 @content
    end

    def ciphertext_salt
      openssl_salted_ciphertext[8..15]
    end

    def encrypted
      openssl_salted_ciphertext[16..-1]
    end
  end
end
