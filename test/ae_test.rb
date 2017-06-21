require "test_helper"

module Hide
  class AETest < Minitest::Test
    extend Minitest::Spec::DSL

    let(:data) { "Data" }
    let(:key) { "passkey" }
    let(:invalid_key) { "bruteforce" }
    let(:salt) { "00000000" }
    let(:iter) { 30_000 }

    let(:encrypt) { AE.encrypt(data, key, salt, iter) }

    let(:decrypted) do
      crypt = encrypt
      AE.decrypt crypt[:data], key, salt, iter, crypt[:iv], crypt[:auth_tag]
    end

    let(:decrypt_with_invalid_cred) do
      crypt = encrypt
      AE.decrypt(
        crypt[:data], invalid_key, salt, iter, crypt[:iv], crypt[:auth_tag]
      )
    end

    def test_assert_encrypt_works_properly
      crypt = encrypt
      assert_instance_of Hash, crypt
      assert_instance_of String, crypt[:data]
      assert_instance_of String, crypt[:iv]
      assert_instance_of String, crypt[:auth_tag]
      assert !crypt[:data].empty?
      assert !crypt[:iv].empty?
      assert !crypt[:auth_tag].empty?
      assert crypt[:data] != data
    end

    def test_assert_decrypt_works_properly
      assert decrypted == data
      exception = assert_raises(ArgumentError) { decrypt_with_invalid_cred }
      assert_equal "Authentication failed", exception.message
    end
  end
end
