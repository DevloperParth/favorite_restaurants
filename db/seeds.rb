# db/seeds.rb

# Create a default user
User.create!(
    email: 'test@yopmail.com',
    password: 'password',
    password_confirmation: 'password'
  )
