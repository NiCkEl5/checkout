require 'minitest/autorun'
require_relative '../discounts.rb'

class DiscountsTest < Minitest::Test
  def test_create_discount
    discounts = Discounts.new
    refute_empty discounts.discounts_list
  end

  def test_create_discount_empty
    discounts = Discounts.new(data: {"discounts"=>[]})
    assert_empty discounts.discounts_list
  end

  def test_get_discunt_bad_call
    assert_raises(ArgumentError) do
      discounts = Discounts.new
      price = discounts.get_product_discount 'GR1', 2
    end
  end

  def test_get_discount
    discounts = Discounts.new
    price = discounts.get_product_discount product_id: 'GR1', product_qty: 2
    assert_equal 3.11, price
  end

  def test_get_discount_bash
    {'GR1'=>{'products_qty' => 2, 'discount' => 3.11},
    'SR1'=>{'products_qty' => 4, 'discount' => 2},
    'CF1'=>{'products_qty' => 5, 'discount' => 18.715}}.each do |product, values|
      discounts = Discounts.new
      price = discounts.get_product_discount product_id: product, product_qty: values['products_qty']
      assert_equal values['discount'], price
    end
  end

  def test_get_unknown_discount
    discounts = Discounts.new
    price = discounts.get_product_discount product_id: 'JL5', product_qty: 2
    assert_equal 0, price
  end
end
