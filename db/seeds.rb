User.destroy_all
Post.destroy_all

puts 'Creating users...'
albo = User.create!(first_name: 'Anthony', last_name: 'Albanese', email: 'albo@gmail.com', password: 'password')
scomo = User.create!(first_name: 'Scott', last_name: 'Morrison', email: 'scomo@gmail.com', password: 'password')
lucas = User.create!(first_name: 'Lucas', last_name: 'Siviglia', email: 'siviglialucas@gmail.com', password: 'password')
menino_ney = User.create!(first_name: 'Menino', last_name: 'Ney', email: 'nj10@gmail.com', password: 'password')

puts 'Creating posts...'
Post.create!(tweet: 'I am the Prime Minister of Australia', user_id: albo.id)
Post.create!(tweet: 'I was the Prime Minister of Australia', user_id: scomo.id)
Post.create!(tweet: 'I am Lucas', user_id: lucas.id)
Post.create!(tweet: 'I am a professional football player', user_id: menino_ney.id)

puts 'Seeds created successfully!'
