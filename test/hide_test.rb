require "test_helper"

class HideTest < Minitest::Test
  extend Minitest::Spec::DSL

  let(:data) { "Data" }
  let(:key) { "passkey" }
  let(:salt) { "00000000" }
  let(:iter) { 30_000 }

  let(:encrypt) { Hide.encrypt(data, key, salt, iter) }

  let(:decrypted) do
    crypt = encrypt
    Hide.decrypt crypt[:data], key, salt, iter, crypt[:iv]
  end

  def test_assert_module_has_a_version_constant
    refute_nil ::Hide::VERSION
  end

  def test_assert_encrypt_works_properly
    crypt = encrypt
    assert_instance_of Hash, crypt
    assert_instance_of String, crypt[:data]
    assert_instance_of String, crypt[:iv]
    assert !crypt[:data].empty?
    assert !crypt[:iv].empty?
    assert crypt[:data] != data
  end

  def test_assert_decrypt_works_properly
    assert decrypted == data
  end
end
