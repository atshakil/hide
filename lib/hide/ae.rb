class Hide::AE
  class << self
    def encrypt data, key, salt, iter, iv = SecureRandom.random_bytes(16),
      auth_data = String.new, key_length = 32
      cipher = OpenSSL::Cipher.new 'aes-256-gcm'
      cipher.encrypt
      cipher.key = OpenSSL::PKCS5.pbkdf2_hmac_sha1(key, salt, iter, key_length)
      cipher.iv = iv
      cipher.auth_data = auth_data
      {
        data: cipher.update(data) + cipher.final,
        iv: iv,
        auth_tag: cipher.auth_tag
      }
    end

    def decrypt data, key, salt, iter, iv, auth_tag, auth_data = String.new,
      key_length = 32
      decipher = OpenSSL::Cipher.new 'aes-256-gcm'
      decipher.decrypt
      decipher.key = OpenSSL::PKCS5.pbkdf2_hmac_sha1(key, salt, iter,
        key_length)
      decipher.iv = iv
      decipher.auth_tag = auth_tag
      decipher.auth_data = auth_data
      decipher.update(data) + decipher.final rescue raise ArgumentError
        .new('Authentication failed')
    end
  end
end