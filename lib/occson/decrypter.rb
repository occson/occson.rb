# frozen_string_literal: true

module Occson
  # Handles client-side decryption for documents.
  #
  # The decrypter uses AES-256 in CBC mode internally. A salt is
  # expected in bytes 8..15, with ciphertext occupying the
  # further bytes.
  class Decrypter
    # Constructs a Decrypter instance with given passphrase and content.
    #
    # @example
    #   Occson::Decrypter.new('the content passphrase', content)
    #
    # @param passphrase [String] Passphrase for content decryption
    # @param content [String] Encrypted document content
    def initialize(passphrase, content)
      @passphrase = passphrase
      @content = content
    end

    # Performs decryption, returning plaintext if passphrase matched.
    #
    # @return [String] Plaintext document content
    def call
      decryptor.pkcs5_keyivgen(@passphrase, ciphertext_salt, 1)
      result = decryptor.update(encrypted)
      result << decryptor.final
    end

    private

    def decryptor
      @decryptor ||= OpenSSL::Cipher.new('aes-256-cbc').decrypt
    end

    def openssl_salted_ciphertext
      @openssl_salted_ciphertext ||= Base64.strict_decode64 @content
    end

    def ciphertext_salt
      openssl_salted_ciphertext[8..15]
    end

    def encrypted
      openssl_salted_ciphertext[16..]
    end
  end
end
