#! /usr/bin/env ruby
require_relative './checkout.rb'

co = Checkout.new
co.scan(purchased_item: 'GR1')
co.scan(purchased_item: 'GR1')
co.scan(purchased_item: 'GR1')
puts co.total