require 'yaml'

class Products
  attr_reader :products_list

  def initialize data: YAML.load(File.read(File.dirname(__FILE__) + '/config/config.yml'))['items']
    @products_list = get_list data
  end

  def get_product_price product_id:
    product = find_item id: product_id
    return product.price
  end

  def get_product_discount product_id: ,product_qty:
    product_description = find_item id: product_id
    if product_description && product_qty >= product_description&.discount_rule.number_of_products
      get_discount(product_discount: product_description.discount_rule, quantity: product_qty)
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

  def find_item id:
    self.products_list.find{|product| product.name==id}
  end

  Product_item = Struct.new(:name, :price, :discount_rule)
  Discount_rule = Struct.new(:type, :number_of_products, :amount)
  def get_list data
    data.collect do |item|
      Product_item.new(item['name'],
                       item['price'],
        Discount_rule.new(item['discount']['type'],
                          item['discount']['number_products'],
                          item['discount']['amount']))
    end
  end
end