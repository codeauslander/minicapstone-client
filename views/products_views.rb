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
end