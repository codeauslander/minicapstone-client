class User
  attr_accessor :id, :name, :email, :password, :password_confirmation
  def initialize(input)
    @id = input["id"]
    @name = input["name"]
    @email = input["email"]
    @password = input["password"]
    @password_confirmation = input["password_confirmation"]
  end
end