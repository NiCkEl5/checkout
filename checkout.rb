require 'yaml'

class Checkout
  attr_accessor :pre_total, :cart, :discounts
  attr_reader :list_pricing

  def initialize(list_pricing: YAML.load(File.read(File.dirname(__FILE__) + '/config/config.yml'))['items'])
    @list_pricing = list_pricing
    @cart=[]
    @discounts = []
    @pre_total = 0
  end

  def scan purchased_item:''
    item_detail = get_product purchased_item
    self.cart << item_detail['name']
    self.discounts |= [item_detail['discount']] if count_products(item_detail['name']) >= item_detail['discount']['number_products']
    self.pre_total += item_detail['price']
  end

  def total
    self.discounts.each do |discount|
      apply_discount discount_rule: discount
    end

    return self.pre_total.round(2)
  end

  private

  def count_products product
    self.cart.count(product)
  end

  def get_product item_name
    self.list_pricing.find{|i| i['name'] == item_name}
  end

  def apply_discount discount_rule:
    items = count_products discount_rule['product_name']
    discount = get_discount discount_rule, items
    self.pre_total -= discount
  end

  def get_discount discount_rule, items
    discount = 0
    case discount_rule['type']
    when 'item'
      discount = items/discount_rule['number_products']
    when 'amount'
      discount = items
    else
      puts 'discount 404'
    end

    return discount * discount_rule['amount']
  end
end
########start########
# co = Checkout.new
# ['GR1','SR1','GR1','GR1','CF1'].each do |item|
#   co.scan(purchased_item: item)
# end
# puts co.total