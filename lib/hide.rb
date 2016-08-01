require 'openssl'
require 'securerandom'

class Hide
  class << self
    def encrypt data, key, salt, iter, iv=SecureRandom.random_bytes(16),
      key_length = 32
      cipher = OpenSSL::Cipher.new 'AES-256-CBC'
      cipher.encrypt
      cipher.key = OpenSSL::PKCS5.pbkdf2_hmac_sha1(key, salt, iter, key_length)
      cipher.iv = iv
      {
        data: cipher.update(data) + cipher.final,
        iv: iv
      }
    end

    def decrypt data, key, salt, iter, iv, key_length
      decipher = OpenSSL::Cipher.new 'AES-256-CBC'
      decipher.decrypt
      decipher.key = OpenSSL::PKCS5.pbkdf2_hmac_sha1(key, salt, iter,
        key_length)
      decipher.iv = iv
      decipher.update(data) + decipher.final
    end
  end
end

require 'hide/ae'
