module UsersController
  def users_create_action
    parameters = users_new_form
    p parameters
    json_data = post_request("/users",parameters)
    p json_data
    user = User.new(json_data)
    p user
    if !json_data['errors']
      user = User.new(json_data)
      p user
      users_show_view(user)
    else
      errors = json_data["errors"]
      users_errors_view(errors)
    end
  end
end