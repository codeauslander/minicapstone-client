require 'tty-table'
module ProductsViews
  def products_show_view(product)
    puts 
    puts "#{product.name} - Id: #{product.id}"
    puts 
    puts product.description
    puts
    puts product.price
    puts product.tax
    puts "-------------------"
    puts product.total
    puts product.in_stock
  end
  def products_index_view(products)
    puts "Products table ... "
    table_rows = []
    products.each do |product|
      table_rows << [product.id,product.name,product.description,product.price,product.tax,product.total,product.in_stock]
    end
    table = TTY::Table.new header: ['Id','Name','Description','Price','Tax','Total','In stock'], rows: table_rows
    renderer = TTY::Table::Renderer::Unicode.new(table)
    puts renderer.render    
  end
  def products_id_form
    print "Enter product id: "
    gets.chomp
  end
  def products_new_form
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
    client_params
  end
  def products_update_form(product)
    client_params = {}    
    print "Name: (#{product.name})"
    client_params[:name] = gets.chomp
    print "Price: (#{product.price})"
    client_params[:price] = gets.chomp
    print "Image_url: (#{product.image_url})"
    client_params[:image_url] = gets.chomp
    print "Description (#{product.description})"
    client_params[:description] = gets.chomp
    print "In_stock (#{product.in_stock})"
    client_params[:in_stock] = gets.chomp
    client_params.delete_if{ |key, value| value.empty?}
  end
  def products_errors_view(errors)
    errors.each do |error|
      puts error
    end
  end
end