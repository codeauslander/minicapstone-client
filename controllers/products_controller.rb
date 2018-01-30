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
  end
  def products_create_action
    parameters = products_new_form
    json_data = post_request("/products",parameters)
    if !json_data['errors']
      product = Product.new(json_data)
      products_show_view(product)
    else
      errors = json_data["errors"]
      products_errors_view(errors)
    end
  end
  def products_update_action
    input_id = products_id_form
    product_hash = get_request("/products/#{input_id}")
    product = Product.new(product_hash)
    parameters = products_update_form(product)
    json_data = patch_request("/products/#{input_id}",parameters)
    if !json_data['errors']
      product = Product.new(json_data)
      products_show_view(product)
    else
      errors = json_data["errors"]
      products_errors_view(errors)
    end
  end
  def products_destroy_action
    input_id = products_id_form
    json_data = delete_request("/products/#{input_id}")
    puts json_data["message"]
  end
  def products_search_action
    print "Enter a name to search: "
    search = gets.chomp
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