# frozen_string_literal: true

module Ccs
  # Encrypts the given content for transmission. Uses AES-256 in CBC
  # mode internally, with salting.
  class Encrypter
    # Constructs an Encrypter instance with given passphrase, content and salt.
    # Salt _must_ be exactly 8 characters long.
    #
    # @example
    #   passphrase = 'my long document passphrase'
    #   content = 'very secret content'
    #   salt = '12345678'
    #
    #   Ccs::Encrypter.new(passphrase, content, salt)
    #
    # @param passphrase [String] Document passphrase.
    # @param content [String] Plaintext content to be encrypted.
    # @param salt [String] Salt to reinforce the encryption, included in
    #   plaintext in the encrypted document.
    def initialize(passphrase, content, salt)
      @passphrase = passphrase
      @content = content
      @salt = salt
    end

    # Performs the actual encryption, returning base64-encoded ciphertext.
    #
    # @return [String] base64-encoded ciphertext
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
