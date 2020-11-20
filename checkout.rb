require 'yaml'
require './products.rb'

class Checkout
  attr_accessor :pre_total, :cart
  attr_reader :products

  def initialize(products: Products.new)
    @products = products
    @cart=[]
    @pre_total = 0
  end

  def scan purchased_item:''
    item_price = products.get_product_price product_id: purchased_item
    process_item item_id: purchased_item, item_price: item_price
  end

  def total
    get_unique_products.each do |item|
      apply_discount product_id: item
    end
    return self.pre_total.round(2)
  end

  private

  def get_unique_products
    self.cart.uniq
  end

  def process_item item_id:, item_price:
    self.cart << item_id
    self.pre_total += item_price
  end

  def count_products product
    self.cart.count(product)
  end

  def apply_discount product_id:
    number_of_items = count_products product_id
    # discount = get_discount rule: discount_rule, items: number_of_items
    discount = products.get_product_discount product_id: product_id, product_qty: number_of_items
    self.pre_total -= discount
  end
end
########start########
# co = Checkout.new
# ['GR1','SR1','GR1','GR1','CF1'].each do |item|
#   co.scan(purchased_item: item)
# end
# puts co.total