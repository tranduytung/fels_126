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

users = User.all
user = users.first
following = users[2..10]
followers = users[3..15]
following.each {|followed| user.follow(followed)}
followers.each {|follower| follower.follow(user)}


15.times do
  name = Faker::Name.title
  content = Faker::Lorem.sentence
  category = Category.create! name: name, content: content
end