require 'unirest'
require 'paint'

running = true

while running == true

  puts "Choose an option"
  puts "    [1] Show all products"
  puts "    [2] Show the first product"
  puts "    [3] Print"

  input_option = gets.chomp

  url = "http://localhost:3000"
    

  if input_option == "1"
    
    url += "/all_products_url"
    puts "This is all the products"
  elsif input_option == "2"
    url += "/first_product_url"
    puts "This is the first product"
  elsif input_option == "3"
    
    puts Paint['These are my products', :red]
    # 255.times do |i|
    #   Paint['Ruby is so much fun', :red]
    # end 
    
  elsif input_option == '4'
    # duck = <<- DUCK
    # "the duch thing"
    # DUCK
    # system 'clear'
    # puts duck

    # gets.chomp
    # system 'clear'

  end
    

  response = Unirest.get(url).body
  puts JSON.pretty_generate(response)

  puts "Enter q to Quit"
  input_option = gets.chomp
  if input_option == "q"
    running = false
  end

end 