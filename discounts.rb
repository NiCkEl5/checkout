require 'yaml'

class Discounts
  attr_accessor :discounts_list

  def initialize data: YAML.load(File.read(File.dirname(__FILE__) + '/config/config.yml'))
    @discounts_list = get_list_discounts data['discounts']
  end

  def get_product_discount product_id: ,product_qty:
    product_discount = find_discount id: product_id
    if product_discount && product_qty >= product_discount.number_of_products
      get_discount(product_discount: product_discount, quantity: product_qty)
    else
      return 0
    end
  end

  private

  def get_discount product_discount:, quantity:
    discount = 0
    case product_discount.type
    when 'item'
      discount = quantity/product_discount.number_of_products
    when 'amount'
      discount = quantity
    else
      return discount
    end

    return discount * product_discount.amount
  end

  def find_discount id:
    self.discounts_list.find{|discount| discount.product_id==id}
  end

  Discount_rule = Struct.new(:product_id, :type, :number_of_products, :amount)
  def get_list_discounts data
    list = []
    return list if data.nil?
    data.each do |discount|
      list << Discount_rule.new(discount['product_id'],
        discount['type'],
        discount['number_products'],
        discount['amount'].to_f) if discount['amount'].to_f > 0
    end
    return list
  end
end