# WELCOME to the Cashier code Challenge!

This simple module act is a cashier function that adds products to a cart and display the total price

Configuration file
-------------------
The configuration file is written in YAML format, we have 2 sections in the file, one for products and other for discounts. The syntax to configurate a product is:

items:
  - name: <id of the product>
    price: <price of the product>
  - name: <name of the product id>
    price: <price of the product>
    ...

Discounts configuration  has the following sectuibs

discounts:
  - product_id: <id of the product>
    type: <type of discount, currently we have 2 types: item and ammount>
    number_products: <number of products that apply for the discount>
    amount: <ammount of the discount>
  - product_id: <id of the product>
    type: <type of discount, currently we have 2 types: item and ammount>
    number_products: <number of products that apply for the discount>
    amount: <ammount of the discount>
    ...

no discounts can be entered but keyword muts be pressent in the file

Running syntax example
----------------------

co = Checkout.new
co.scan(item)
co.scan(item)
price = co.total

Or entering data manually

co = Checkout.new(products: Products.new(data: {"items"=>[{"name"=>"GR1", "price"=>3.11}]}), discounts: Discounts.new(data: {"discounts"=>[]}))

co.scan(item)
co.scan(item)
price = co.total