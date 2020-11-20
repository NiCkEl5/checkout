require 'yaml'

class Products
  attr_reader :products_list

  def initialize data: YAML.load(File.read(File.dirname(__FILE__) + '/config/config.yml'))
    @products_list = get_list data['items']
  end

  def get_product_price product_id:
    product = find_item id: product_id
    return product.nil? ? nil : product.price
  end

  private

  def find_item id:
    self.products_list.find{|product| product.name==id}
  end

  Product_item = Struct.new(:name, :price)

  def get_list data
    list = []
    data.each do |item|
      list << Product_item.new(item['name'], item['price'].to_f) if item['price'].to_f > 0
    end
    return list
  end
end