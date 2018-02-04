require 'unirest'
require 'paint'
require_relative 'controllers/products_controller'
require_relative 'views/products_views'
require_relative 'models/product'

require_relative 'controllers/users_controller'
require_relative 'views/users_views'
require_relative 'models/user'

class Frontend
  include ProductsController
  include ProductsViews

  include UsersController
  include UsersViews

  def run
    system 'clear'
    running = true
    user_email = "Welcome visitor"
    while running == true
      system 'clear'
      puts "#{user_email}      
      Choose an option (Query URL)
        [a] Show products
        [s] Show a product
        [d] Print

      Choose an option (REST)
          [1] Show all products
            [1.1] Search by name
            [1.2] Sort by name
            [1.3] Sort by price
            [1.4] Show all produucts by category
          [2] Show one product
          [3] Create a new product
          [4] Update a product
          [5] Destroy a product

          [signup] Sing up (Create user)
          [login]  Login (Create a User token)
          [logout] Logout (Destroy jwt)
          [cart] Show carted products

          [6] Create a User (Sign up)
          [7] Show all orders
          [8] Add a product to your cart
          [9] Show all carted products
          [ ] Everything else bye"
      input_option = gets.chomp
      case input_option
      when "a"
        puts JSON.pretty_generate(Unirest.get("http://localhost:3000/all_products_url").body)
      when "s"
        puts JSON.pretty_generate(Unirest.get("http://localhost:3000/first_product_url").body)
      when "d"
        puts Paint['These are my products', :red]
      when "1"
        products_index_action
      when "1.1"
        products_search_action
      when "1.2"
        products_sort_action("name")
      when "1.3"
          products_sort_action("price")
      when "1.4"
        puts
        response = Unirest.get("http://localhost:3000/categories")
        category_hashs = response.body
        category_hashs.each do |category_hash|
          puts "- #{category_hash['name']}"
        end

        print "Enter a category name:"
        category_name = gets.chomp
        response = Unirest.get("http://localhost:3000/products?category=#{category_name}")
        product_hashs = response.body
        product_hashs.each do |product_hash|
          puts "- #{product_hash['name']}"
        end
      when "2"
        products_show_action
      when "3"
        products_create_action
      when "4"
        products_update_action
      when "5"
        products_destroy_action
      when "6"
        users_create_action
      when "signup"
        puts "Signup for a new account"
        puts
        parameters = {}
        print "Name: "
        parameters[:name]=gets.chomp
        print "Email: "
        parameters[:email]=gets.chomp
        print "Password: "
        parameters[:password]=gets.chomp
        print "Password confirmation: "
        parameters[:password_confirmation]=gets.chomp
        json_data = post_request("/users",parameters)
        puts JSON.pretty_generate(json_data)
      when "login"
        puts "Login"
        puts
        print "Email: "
        input_email = gets.chomp
        print "Password: "
        input_password = gets.chomp
        response = Unirest.post(
            "http://localhost:3000/user_token",
            parameters:{
              auth:{
                email:input_email,
                password:input_password
              }
            }
          )
      puts JSON.pretty_generate(response.body)
      jwt = response.body["jwt"]
      Unirest.default_header("Authorization","Bearer #{jwt}")
      user_email = "Welcome user: #{input_email}"
      when 'logout'
        jwt = ""
        Unirest.clear_default_headers
      when 'cart'
        puts
        puts "Here are all the items in your shopping cart"
        puts
        response = Unirest.get("http://localhost:3000/carted_products")
        carted_products = response.body
        # carted_products.each do |carted_product_hash|
        #   puts "* #{carted_product_hash["product"]["name"]}"
        # end
        puts JSON.pretty_generate(carted_products)
        puts "Press enter to continue, or press 'o' to place the order"
        if gets.chomp == 'o'
          response = Unirest.post('http://localhost:3000/orders')
          orders_hash = response.body
          puts JSON.pretty_generate(orders_hashs)
        end
      when '7'
        orders_hashs = get_request("/orders")
        response = Unirest.get("http://localhost:3000/orders")
        if response.code == 200
          puts JSON.pretty_generate(response.body)
        elsif response.code == 401
          puts "You do not have a list of orders until you sign in, Jerk"
        end
      when "8"
        puts "Adding a product to your cart"
        print "Enter product id: "
        parameters = {}
        parameters[:product_id] = gets.chomp
        print "Enter quantity: "
        parameters[:quantity] = gets.chomp
        print "Enter order id: "
        parameters[:order_id] = gets.chomp
        print "Enter order id"
        parameters[:status] = "carted"
        response = Unirest.post("http://localhost:3000/carted_products",parameters:parameters)
        puts JSON.pretty_generate(response.body)
      when "9"
        puts "Showing all carted products" 
        response = Unirest.get("http://localhost:3000/carted_products")
        carted_products_hashs = response.body
        carted_products_hashs.each do |carted_product|
          puts "
          #{carted_product['status']} 
          #{carted_product['user_id']} 
          #{carted_product['product_id']} 
          #{carted_product['order_id']}"
        end


        # product_hashs = response.body
        # product_hashs.each do |product_hash|
        #   puts "- #{product_hash['name']}"
        # end

      else
        system 'clear'
        exit
      end
      puts "Enter q to Quit or hit enter to continue"
      input_option = gets.chomp
      if input_option == "q"
        system 'clear'
        running = false
      end
    end
  end
  private
  def get_request(url,parameters={})
    Unirest.get("http://localhost:3000#{url}",parameters: parameters).body
  end
  def post_request(url,parameters={})
    Unirest.post("http://localhost:3000#{url}",parameters:parameters).body
  end
  def patch_request(url,parameters={})
    Unirest.patch("http://localhost:3000#{url}",parameters:parameters).body
  end
  def delete_request(url,parameters={})
    Unirest.delete("http://localhost:3000#{url}",parameters: parameters).body
  end
end