require 'tty-table'
module UsersViews
    def users_show_view(user)
        puts "User created"
        puts user.name
        puts user.email
    end

    def users_new_form
        parameters = {}    
        print "Name: "
        parameters[:name] = gets.chomp
        print "Email: "
        parameters[:email] = gets.chomp
        print "Password: "
        parameters[:password] = gets.chomp
        print "Password confirmation: "
        parameters[:password_confirmation] = gets.chomp
        parameters.delete_if{ |key, value| value.empty?}
        parameters
    end

    def users_errors_view(errors)
    errors.each do |error|
      puts error
    end
  end
end