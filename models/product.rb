class Product
  attr_accessor :id, :name, :image_url, :description, :is_discounted, :tax, :total, :price, :formatted_price, :in_stock, :supplier_name
  def initialize(input)
    @id = input["id"]
    @name = input["name"]
    @image_url = input["image_url"]
    @description = input["description"]
    @is_discounted = input["is_discounted"]
    @tax = input["tax"]
    @total = input["total"]
    @price = input["price"]
    @formatted_price = input["formatted_price"]
    @in_stock = input["in_stock"]
    @supplier = input["supplier_name"]
  end
  def self.convert_hashs(products_hashs)
    collection = []
    products_hashs.each do |product_hash|
      collection << Product.new(product_hash)
    end
    collection
  end
end