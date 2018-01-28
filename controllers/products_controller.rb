module ProductsController
  def products_index_action
    response = Unirest.get("http://localhost:3000/products")
    products_hashs = response.body
    products = []
    products_hashs.each do |product_hash|
      products << Product.new(product_hash)
    end

    products_index_view(products)
  end
  def products_search_action
    print "Enter a name to search: "
    search = gets.chomp
    response = Unirest.get("http://localhost:3000/products?search=#{search}")
    products = response.body
    puts JSON.pretty_generate(products)
  end
  def products_sort_action
    print "Enter an attribute to sort: "
    sort = gets.chomp
    response = Unirest.get("http://localhost:3000/products?sort=#{sort}")
    products = response.body
    puts JSON.pretty_generate(products)
  end
  def products_show_action
    print "Enter product id: "
    input_id = gets.chomp
    response = Unirest.get("http://localhost:3000/products/#{input_id}")
    product_hash = response.body
    product = Product.new(product_hash)

    products_show_view(product)
  end
  def products_create_action
    client_params = {}
    print "Name: "
    client_params[:name] = gets.chomp
    print "Price: "
    client_params[:price] = gets.chomp
    print "Image_url: "
    client_params[:image_url] = gets.chomp
    print "Description: "
    client_params[:description] = gets.chomp
    print "In_stock: "
    client_params[:in_stock] = gets.chomp
    response = Unirest.post(
        "http://localhost:3000/products",
        parameters:client_params
      )
    if response.code == 200
      product_hash = response.body
      product = Product.new(product_hash)
      products_show_view(product)
    else
      errors = response.body["errors"]
      errors.each do |error|
        puts error
      end
    end
  end
  def products_update_action
    client_params = {}
    print "Enter product id: "
    input_id = gets.chomp
    response = Unirest.get("http://localhost:3000/products/#{input_id}")
    product = response.body
    print "Name: (#{product['name']})"
    client_params[:name] = gets.chomp
    print "Price: (#{product['price']})"
    client_params[:price] = gets.chomp
    print "Image_url: (#{product['image_url']})"
    client_params[:image_url] = gets.chomp
    print "Description (#{product['description']})"
    client_params[:description] = gets.chomp
    print "In_stock (#{product['in_stock']})"
    client_params[:in_stock] = gets.chomp
    client_params.delete_if{ |key, value| value.empty?}
    response = Unirest.patch(
        "http://localhost:3000/products/#{input_id}",
        parameters:client_params
      )
    if response.code == 200
      product = response.body
      puts JSON.pretty_generate(product)
    else
      errors = response.body["errors"]
      errors.each do |error|
        puts error
      end
    end
  end
  def products_destroy_action
    print "Enter product id: "
    input_id = gets.chomp
    response = Unirest.delete("http://localhost:3000/products/#{input_id}")
    data = response.body
    puts data["message"]
  end
end