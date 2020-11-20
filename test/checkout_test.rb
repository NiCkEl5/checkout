#! /usr/bin/env ruby
require 'minitest/autorun'
require_relative '../checkout.rb'

class CheckoutTest < Minitest::Test
  def test_create_checkout
    co = Checkout.new
    assert co
    refute_nil co.list_pricing, 'princing_rules attribute dont exist'
  end

  def test_scan_one_item
    co = Checkout.new
    assert co
    co.scan(purchased_item: 'GR1')
    assert_equal 3.11, co.total
  end

  def test_calculate_disscount
    co = Checkout.new
    ['GR1','SR1','GR1','GR1','CF1'].each do |item|
      co.scan(purchased_item: item)
    end
    assert_equal 22.45, co.total
  end

  def test_calculate_disscount2
    co = Checkout.new
    ['GR1','GR1',].each do |item|
      co.scan(purchased_item: item)
    end
    assert_equal 3.11, co.total
  end

  def test_calculate_disscount3
    co = Checkout.new
    ['SR1','SR1','GR1','SR1'].each do |item|
      co.scan(purchased_item: item)
    end
    assert_equal 16.61, co.total
  end

  def test_calculate_disscount4
    co = Checkout.new
    ['GR1','CF1','SR1','CF1','CF1'].each do |item|
      co.scan(purchased_item: item)
    end
    assert_equal 30.57, co.total
  end
end