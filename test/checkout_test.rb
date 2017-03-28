require 'minitest/autorun'

require_relative '../application/checkout'
require_relative '../application/rule'

class CheckoutTest < MiniTest::Test

  def price goods
    rules = [Rule.new('A',50),
             Rule.new('A',130,3),
             Rule.new('B',30),
             Rule.new('B',45,2),
             Rule.new('C',20),
             Rule.new('D',15)]


    co = Checkout.new rules
    goods.split(//).each do |item|
      co.scan(item)
    end
    co.total
  end

  def test_no_item
    assert_equal(0, price(""))
  end

  def test_one_item
    assert_equal(50, price("A"))
  end

  def test_two_items
    assert_equal(80, price("AB"))
  end

  def test_many_items
    assert_equal(165, price("ABACD"))
  end

  def test_discount_item
    assert_equal(130, price("AAA"))
  end

  def test_discount_item_plus
    assert_equal(180, price("AABCA"))
  end

  def test_aleatory
    assert_equal(160, price("AAAB"))
    assert_equal(175, price("AAABB"))
    assert_equal(190, price("AAABBD"))
    assert_equal(190, price("DABABA"))
  end
end
