user = User.create(email: "user@admin.com", password: "password")

3.times do |x|
  user.todos.create(title: "Title_#{x}", description: "Description_#{x}")
end
