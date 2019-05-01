require 'minitest/unit'
require 'minitest/autorun'
require './vb_with_ruby'
require 'pry'

class TestVbCode < MiniTest::Unit::TestCase

  include VbCode

  def test_vb_encode
    assert_equal ['10000001'], VbCode.vb_encode(1).unpack('B*')
    assert_equal ['10000101'], VbCode.vb_encode(5).unpack('B*')
    assert_equal ['11111111'], VbCode.vb_encode(127).unpack('B*')
    assert_equal ['0000000110000000'], VbCode.vb_encode(128).unpack('B*')
    assert_equal ['0000000110000001'], VbCode.vb_encode(129).unpack('B*')
  end

  def test_vb_decode
    (1..9999).each do |n|
      assert_equal [n], VbCode.vb_decode(VbCode.vb_encode(n))
    end
  end
end