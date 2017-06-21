require "openssl"
require "securerandom"
require "hide/version"
require "hide/ae"

# The primary module for `hide`
#
# Provides basic encryption/decryption support
module Hide
  module_function

  # Encrypts a data stream without any authentication identifier.
  #
  # For authenticated encryption support please use `Hide::AE` module
  def encrypt(
    data, key, salt, iter, iv = SecureRandom.random_bytes(16), key_length = 32
  )
    cipher = OpenSSL::Cipher.new "AES-256-CBC"
    cipher.encrypt
    cipher.key = OpenSSL::PKCS5.pbkdf2_hmac_sha1(key, salt, iter, key_length)
    cipher.iv = iv
    {
      data: cipher.update(data) + cipher.final,
      iv: iv
    }
  end

  # Decrypts any datastream with provided decryption credential and
  # configuration.
  #
  # This method does not provide support for authenticated encryption.
  # For authenticated encryption support, please use `Hide::AE` module
  def decrypt data, key, salt, iter, iv, key_length = 32
    decipher = OpenSSL::Cipher.new "AES-256-CBC"
    decipher.decrypt
    decipher.key = OpenSSL::PKCS5.pbkdf2_hmac_sha1(key, salt, iter, key_length)
    decipher.iv = iv
    decipher.update(data) + decipher.final
  end
end
