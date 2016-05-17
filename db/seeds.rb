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

cate = Category.order(:created_at)
cate.each { |cate|
  50.times do
    word = cate.words.build content: Faker::Lorem.characters(5)
    word.answers = [
      Answer.new(content: Faker::Lorem.characters(5), is_correct: true),
      Answer.new(content: Faker::Lorem.characters(5), is_correct: false),
      Answer.new(content: Faker::Lorem.characters(5), is_correct: false),
      Answer.new(content: Faker::Lorem.characters(5), is_correct: false)
    ].shuffle
    word.save!
  end
}

category_new = Category.create!(
  name: "N3",
  content: "De thi N3")
5.times do
word_new = category_new.words.build content: Faker::Lorem.characters(5)
    word_new.answers = [
      Answer.new(content: Faker::Lorem.characters(5), is_correct: true),
      Answer.new(content: Faker::Lorem.characters(5), is_correct: false),
      Answer.new(content: Faker::Lorem.characters(5), is_correct: false),
      Answer.new(content: Faker::Lorem.characters(5), is_correct: false)
    ].shuffle
    word_new.save!
end
