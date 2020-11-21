# WELCOME to the Cashier code Challenge!

This simple module act is a cashier function that adds products to a cart and display the total price

Running syntax example
----------------------

```
co = Checkout.new
co.scan(item)
co.scan(item)
price = co.total
```

Or entering data manually

```
co = Checkout.new(products: Products.new(data: {"items"=>[{"name"=>"GR1", "price"=>3.11}]}), discounts: Discounts.new(data: {"discounts"=>[]}))
co.scan(item)
co.scan(item)
price = co.total
```
Configuration file
-------------------
The configuration file is written in YAML format, we have 2 sections in the file, one for products and other for discounts. The syntax to configurate a product is:

items:
  - name: <id_of_the_product_string>
  - price: <price_of_the_product_int>

Discounts configuration  has the following sectuibs

discounts:
  - product_id: <id_of_the_product_string>
  - type: <type_of_discount_string, currently_we_have_2_types: item and ammount>
  - number_products: <number_of_products_int_that_apply_for_the_discount>
  - amount: <ammount_of_the_discount_float>

no discounts can be entered but keyword muts be pressent in the file