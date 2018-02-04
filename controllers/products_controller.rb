module ProductsController
  def products_index_action
    products_hashs = get_request("/products")
    products = Product.convert_hashs(products_hashs)
    products_index_view(products)
  end
  def products_show_action
    input_id = products_id_form
    product_hash = get_request("/products/#{input_id}")
    product = Product.new(product_hash)
    products_show_view(product)
    puts "Press enter to continue or type 'o' to add to the cart"
    user_choice = gets.chomp
    if user_choice == 'o'
      print "Enter a quantity to order: "
      quantity = gets.chomp
      parameters = {
        quantity: quantity,
        product_id: input_id
      }
      # json_data = post_request("/carted_products",parameters)
      response = Unirest.post("http://localhost:3000/carted_products",parameters:parameters)
      if response.code == 200
        puts JSON.pretty_generate(response.body)    
      elsif response.code == 401
        puts "Nope, try logging in first"  
      end
    end
  end
  def products_create_action
    parameters = products_new_form
    # json_data = post_request("/products",parameters)
    response = Unirest.post("http://localhost:3000/products",parameters:parameters)
    # if !json_data['errors']
    if response.code == 200
      # product = Product.new(json_data)
      product = Product.new(response.body)
      products_show_view(product)
    elsif response.code == 422
      # errors = json_data["errors"]
      errors = response.body["errors"]
      products_errors_view(errors)
    elsif response.code == 401
      puts JSON.pretty_generate(response.body)
    end
  end
  def products_update_action
    input_id = products_id_form
    product_hash = get_request("/products/#{input_id}")
    product = Product.new(product_hash)
    parameters = products_update_form(product)
    # json_data = patch_request("/products/#{input_id}",parameters)
    response = Unirest.patch("http://localhost:3000/products/#{input_id}",parameters)
    # if !json_data['errors']
    if response.code == 200
      # product = Product.new(json_data)
      product = Product.new(response.body)
      products_show_view(product)
    elsif response.code == 422
      # errors = json_data["errors"]
      errors = response.body["errors"]
      products_errors_view(errors)
    elsif response.code == 401
        puts JSON.pretty_generate(response.body)
    end
  end
  def products_destroy_action
    input_id = products_id_form
    json_data = delete_request("/products/#{input_id}")
    puts json_data["message"]
    # response = Unirest.delete("http://localhost:3000/products/#{input_id}")
    # if response.code == 200
    #   puts response.body["message"]
    # elsif response.code == 422
    #     errors = response.body["errors"]
        
    # end
  end
  def products_search_action
    
    search = products_search_form
    products_hashs = get_request("products?search=#{search}")
    products = Product.convert_hashs(products_hashs)
    products_index_view(products)
  end
  def products_sort_action(sort)
    products_hashs = get_request("/products?sort=#{sort}")
    products = Product.convert_hashs(products_hashs)
    products_index_view(products)
  end
end