require 'minitest/autorun'
require_relative '../discounts.rb'

class DiscountsTest < Minitest::Test
  def test_create_discount
    discounts = Discounts.new
    assert discounts
    refute_empty discounts.discounts_list, 'princing_rules attribute dont exist'
  end

  def test_create_discount_withouth_data
    discounts = Discounts.new(data: {"discounts"=>[]})
    assert discounts
    assert_empty discounts.discounts_list
  end

  def test_get_discount_blank_price
    assert_raises(ArgumentError) do
      discounts = Discounts.new
      price = discounts.get_product_discount 'GR1', 2
    end
  end

  def test_get_discount_discount
    discounts = Discounts.new
    price = discounts.get_product_discount product_id: 'GR1', product_qty: 2
    assert_equal 3.11, price
  end

  def test_get_unknown_discount
    discounts = Discounts.new
    price = discounts.get_product_discount product_id: 'JL5', product_qty: 2
    assert_equal 0, price
  end
end
