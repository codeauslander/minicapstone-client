require 'unirest'
require 'paint'
require_relative 'controllers/products_controller'
require_relative 'views/products_views'
require_relative 'models/product'
class Frontend
  include ProductsController
  include ProductsViews
  def run
    running = true
    while running == true
      puts "Query URL
        [a] Show products
        [s] Show a product
        [d] Print

      Choose an option (REST)
          [1] Show all products
            [1.1] Search by name
            [1.2] Sort by name
            [1.3] Sort by price
          [2] Show one product
          [3] Create a new product
          [4] Update a product
          [5] Destroy a product
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
      when "2"
        products_show_action
      when "3"
        products_create_action
      when "4"
        products_update_action
      when "5"
        products_destroy_action
      else
        system 'clear'
        break
      end
      puts "Enter q to Quit"
      input_option = gets.chomp
      if input_option == "q"
        system 'clear'
        running = false
      end
    end
  end
  private
  def get_request(url,parameters={})
    Unirest.get("http://localhost:3000#{url}").body
  end
  def post_request(url,parameters={})
    response = Unirest.post("http://localhost:3000#{url}"
      ,parameters:parameters)
    if response.code == 200
      return response.body
    end
    return nil
  end
  def patch_request(url,parameters={})
    response = Unirest.patch("http://localhost:3000#{url}"
      ,parameters:parameters).body
  end
  def delete_request(url,parameters={})
    response = Unirest.delete("http://localhost:3000#{url}").body
  end
end