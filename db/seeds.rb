User.create!(
  name: "Admin",
  email: "admin@railstutorial.org",
  password: "admin123",
  password_confirmation: "admin123",
  admin: true)

20.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(
    name: name,
    email: email,
    password: password,
    password_confirmation: password)
end