require "test_helper"

class HideTest < Minitest::Test
  def test_assert_module_has_a_version_constant
    refute_nil ::Hide::VERSION
  end
end
