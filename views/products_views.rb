require 'tty-table'
module ProductsViews
  def products_show_view(product)
    puts 
    puts "#{product.name} - Id: #{product.id}"
    puts 
    product.description_lines.each do |description_line|
      puts description_line
    end
    puts
    puts product.formatted_price
    puts product.formatted_tax
    puts "-------------------"
    puts product.formatted_total
    puts "In stock: #{product.in_stock}"
    puts "images urls"
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
    print "Image url: "
    parameters[:image_url] = gets.chomp
    print "Description: "
    parameters[:description] = gets.chomp
    print "In stock: "
    parameters[:in_stock] = gets.chomp
    print "Supplier Id: "
    parameters[:supplier_id] = gets.chomp
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
  def products_search_form
    print "Enter a name to search by: "
    gets.chomp
  end
end