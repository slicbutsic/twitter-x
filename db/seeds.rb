User.destroy_all
Post.destroy_all
Comment.destroy_all
Like.destroy_all
Follow.destroy_all


puts 'Creating users...'
albo = User.create!(first_name: 'Anthony', last_name: 'Albanese', bio: 'Australia`s Prime Minister', email: 'albo@gmail.com', password: 'password')
scomo = User.create!(first_name: 'Scott', last_name: 'Morrison', email: 'scomo@gmail.com', password: 'password')
lucas = User.create!(first_name: 'Lucas', last_name: 'Siviglia', bio: '🇧🇷🇧🇷🇧🇷🇧🇷🇧🇷🇧🇷', email: 'siviglialucas@gmail.com', password: 'password')
menino_ney = User.create!(first_name: 'Menino', last_name: 'Ney', bio: 'Football Player', email: 'nj10@gmail.com', password: 'password')

# Create additional 100 random users using Faker
100.times do |i|
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name

  # Ensure a unique email based on the user index (i) or user ID
  email = "user#{i + 1}@example.com"

  password = 'password'

  User.create!(
    first_name: first_name,
    last_name: last_name,
    bio: Faker::Quote.most_interesting_man_in_the_world.truncate(100),
    email: email,
    password: password
  )
end

puts 'Users created successfully!'

# Lucas follows 30 random users (excluding himself)
puts 'Creating follow relationships for Lucas...'
random_users = User.where.not(id: lucas.id).sample(30)  # Randomly select 30 users
random_users.each do |user|
  Follow.create!(follower_id: lucas.id, following_id: user.id)
end

puts 'Lucas follow relationships created successfully!'

# All other users follow 5-10 random users (excluding themselves)
puts 'Creating follow relationships for other users...'
User.where.not(id: lucas.id).find_each do |user|
  # Select a random number of users (5-10) for each user to follow
  following_users = User.where.not(id: user.id).sample(rand(5..10))
  following_users.each do |following_user|
    Follow.create!(follower_id: user.id, following_id: following_user.id)
  end
end

puts 'Follow relationships for other users created successfully!'

# Create at least 5 posts for each user
puts 'Creating posts...'
User.find_each do |user|
  5.times do
    Post.create!(tweet: Faker::Lorem.sentence, user_id: user.id)
  end
end

puts 'Posts created successfully!'

# Create comments for posts
puts 'Creating comments...'
Post.find_each do |post|
  # Add 1-3 random comments for each post
  rand(1..3).times do
    Comment.create!(
      body: Faker::Lorem.sentence,
      user_id: User.order('RANDOM()').first.id,  # Random user
      post_id: post.id
    )
  end
end

puts 'Comments created successfully!'

# Create likes for posts (Ensuring a user can like a post only once)
puts 'Creating likes...'
Post.find_each do |post|
  # Add 1-5 likes for each post
  rand(1..5).times do
    user = User.order('RANDOM()').first  # Random user

    # Ensure a user only likes a post once
    unless Like.exists?(user_id: user.id, post_id: post.id)
      Like.create!(
        user_id: user.id,
        post_id: post.id
      )
    end
  end
end

puts 'Likes created successfully!'

puts 'All seed data created successfully!'
