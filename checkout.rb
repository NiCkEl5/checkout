require './products.rb'
require './discounts.rb'

class Checkout
  attr_accessor :pre_total, :cart, :discounts_total
  attr_reader :products, :discounts
  private :pre_total=

  def initialize(products: Products.new, discounts: Discounts.new)
    @products = products
    @discounts = discounts
    @cart=[]
    @pre_total = 0
    @discounts_total = 0
  end

  def scan purchased_item:''
    item_price = products.get_product_price product_id: purchased_item
    process_item item_id: purchased_item, item_price: item_price unless item_price.nil?
  end

  def total
    apply_discount
    (self.pre_total - self.discounts_total).round(2)
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

  def apply_discount
    self.discounts_total = 0
    get_unique_products.each do |product_id|
      number_of_items = count_products product_id
      discount = discounts.get_product_discount product_id: product_id, product_qty: number_of_items
      self.discounts_total += discount
    end

  end
end