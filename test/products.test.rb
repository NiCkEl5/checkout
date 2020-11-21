require 'minitest/autorun'
require_relative '../products.rb'

class ProductsTest < Minitest::Test
  def test_create_product
    products = Products.new
    refute_empty products.products_list
  end

  def test_create_products_empty
    products = Products.new data: {"items"=>[]}
    assert_empty products.products_list
  end

  def test_get_product_bad_call
    assert_raises(ArgumentError) do
      products = Products.new
      products.get_product_price
    end
  end

  def test_get_product_price
    products = Products.new
    price = products.get_product_price product_id: 'GR1'
    assert_equal 3.11, price
  end

  def test_get_unknonwn_product
    products = Products.new
    price = products.get_product_price product_id: 'JL5'
    assert_nil price
  end
end
