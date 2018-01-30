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
    puts "images_urls"
    product.images_urls.each do |image_url|
      puts "*#{image_url}"
    end
  end
  def products_index_view(products)
    puts "Products table ... "
    table_rows = []
    products.each do |product|
      table_rows << [product.id,product.name,product.description,product.price,product.tax,product.total,product.in_stock,product.images_urls]
    end
    table = TTY::Table.new header: ['Id','Name','Description','Price','Tax','Total','In stock','Images urls'], rows: table_rows
    renderer = TTY::Table::Renderer::Unicode.new(table)
    puts renderer.render    
  end
  def products_id_form
    print "Enter product id: "
    gets.chomp
  end
  def products_new_form
    parameters = {}
    print "Name: "
    parameters[:name] = gets.chomp
    print "Price: "
    parameters[:price] = gets.chomp
    print "Image_url: "
    parameters[:image_url] = gets.chomp
    print "Description: "
    parameters[:description] = gets.chomp
    print "In_stock: "
    parameters[:in_stock] = gets.chomp
    parameters
  end
  def products_update_form(product)
    parameters = {}    
    print "Name: (#{product.name})"
    parameters[:name] = gets.chomp
    print "Price: (#{product.price})"
    parameters[:price] = gets.chomp
    print "Image_url: (#{product.image_url})"
    parameters[:image_url] = gets.chomp
    print "Description (#{product.description})"
    parameters[:description] = gets.chomp
    print "In_stock (#{product.in_stock})"
    parameters[:in_stock] = gets.chomp
    print "Supplier Id (#{product.supplier_id})"
    parameters[:supplier_id] = gets.chomp
    parameters.delete_if{ |key, value| value.empty?}
    parameters
  end
  def products_errors_view(errors)
    errors.each do |error|
      puts error
    end
  end
end