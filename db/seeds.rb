# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


puts 'Cleaning database now...'
Provider.destroy_all
User.destroy_all
Address.destroy_all
Move.destroy_all
puts 'Database clean ✅'


# Provider:

provider = Provider.new
provider.name = 'Test Provider'
provider.description = 'Test Description'
provider.category = 'Sports'
provider.provider_email = 'provider@gmail.com'
provider.save!




# User:
user = User.new
user.email = 'bob@gmail.com'
user.password = '123456'
user.first_name = "Bob"
user.last_name = "Fredo"
user.phone_number = "070723573"
random_day = rand(19..30)
user.birthday = DateTime.new(1993, 03, random_day)
user.save!


user = User.new
user.email = 'bill@gmail.com'
user.password = '123456'
user.first_name = "Bill"
user.last_name = "Fredo"
user.phone_number = "078457838"
random_day = rand(19..30)
user.birthday = DateTime.new(1993, 04, random_day)
user.save!

user = User.new
user.email = 'joe@gmail.com'
user.password = '123456'
user.first_name = "Joe"
user.last_name = "Worren"
user.phone_number = "0784587"
random_day = rand(19..30)
user.birthday = DateTime.new(1991, 05, random_day)
user.save!

user = User.new
user.email = 'daniel@gmail.com'
user.password = '123456'
user.first_name = "Daniel"
user.last_name = "Bosh"
user.phone_number = "07845878"
random_day = rand(19..30)
user.birthday = DateTime.new(1990, 11, random_day)
user.save!

user = User.new
user.email = 'nick@gmail.com'
user.password = '123456'
user.first_name = "Nick"
user.last_name = "Peters"
user.phone_number = "07845898"
random_day = rand(19..30)
user.birthday = DateTime.new(1999, 11, random_day)
user.save!


#Address
address = Address.new
address.city = "Berlin"
address.street_number = "23"
address.street_name = "Schlosstr"
address.zip = "12163"
address.save!

address = Address.new
address.city = "Berlin"
address.street_number = "25"
address.street_name = "Schlosstr"
address.zip = "12163"
address.save!

address = Address.new
address.city = "Berlin"
address.street_number = "2"
address.street_name = "Bundesplatz"
address.zip = "12163"
address.save!

#Move
move = Move.new
random_day = rand(19..30)
move.moving_date = DateTime.new(2020, 11, random_day)
move.save!

move = Move.new
random_day = rand(19..30)
move.moving_date = DateTime.new(2020, 12, random_day)
move.save!

move = Move.new
random_day = rand(19..30)
move.moving_date = DateTime.new(2021, 01, random_day)
move.save!

move = Move.new
random_day = rand(19..30)
move.moving_date = DateTime.new(2021, 01, random_day)
move.save!

puts "Done!"
puts "Created #{Provider.count} providers."
puts "Created #{User.count} users."
puts "Created #{Address.count} addresses."
puts "Created #{Move.count} moves."