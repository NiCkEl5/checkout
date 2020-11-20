require 'minitest/autorun'
require_relative '../products.rb'

class ProductsTest < Minitest::Test
  def test_create_product
    products = Products.new
    assert products
    refute_nil products.products_list, 'princing_rules attribute dont exist'
  end

  def test_get_product_price
    products = Products.new
    price = products.get_product_price product_id: 'GR1'
    assert_equal 3.11, price
  end

  def test_get_product_discount
    products = Products.new
    price = products.get_product_discount product_id: 'GR1', product_qty: 2
    assert_equal 3.11, price
  end
end
