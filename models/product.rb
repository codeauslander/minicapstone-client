class Product
  attr_accessor :id, :name, :image_url, :description, :is_discounted, :tax, :total, :price, :formatted_price, :formatted_tax, :formatted_total, :in_stock, :supplier_id, :supplier_name, :images_urls
  def initialize(input)
    @id = input["id"]
    @name = input["name"]
    @image_url = input['image_url']
    @description = input["description"]
    @is_discounted = input["is_discounted"]

    @tax = input["tax"]
    @total = input["total"]
    @price = input["price"]

    @formatted_tax = input["formatted"]["tax"]
    @formatted_total = input["formatted"]["total"]
    @formatted_price = input["formatted"]["price"]
   
    @in_stock = input["in_stock"]
    @supplier_id = input["supplier"]["id"]
    @supplier_name = input["supplier"]["name"]

    @images_urls = input["images"].map{|image_hash| image_hash["url"]}

  end
  def self.convert_hashs(products_hashs)
    collection = []
    products_hashs.each do |product_hash|
      collection << Product.new(product_hash)
    end
    collection
  end
  def description_lines
    description.scan(/.{0,40}/)
  end
end