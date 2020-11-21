#! /usr/bin/env ruby
require 'minitest/autorun'
require_relative '../checkout.rb'

class CheckoutTest < Minitest::Test
  def test_create_checkout
    co = Checkout.new
    assert_kind_of(Products, co.products)
    assert_kind_of(Discounts, co.discounts)
  end

  def test_scan_one_item
    co = Checkout.new
    co.scan(purchased_item: 'GR1')
    assert_equal 3.11, co.total
  end

  def test_scan_one_unknown_item
    co = Checkout.new
    co.scan(purchased_item: 'JL5')
    assert_equal 0, co.total
  end

  def test_calculate_shop
    { 22.45 => ['GR1','SR1','GR1','GR1','CF1'],
     3.11 => ['GR1','GR1'],
     16.61 => ['SR1','SR1','GR1','SR1'],
     30.57 => ['GR1','CF1','SR1','CF1', 'CF1']}.each do |total_expected, products|
      co = Checkout.new
      products.each do |product|
        co.scan(purchased_item: product)
      end
      assert_equal total_expected, co.total
    end
  end

end