# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


puts 'Cleaning database now...'
User.destroy_all
Provider.destroy_all
MyProvider.destroy_all
Update.destroy_all
puts 'Database clean ✅'


# User -> TO BE DELETED -> MILENAS TO BE USED
user1 = User.new
user1.first_name = 'Test First Name' # to be replaced with Milenas seed
user1.email = 'test@gmail.com' # to be replaced with Milenas seed
user1.password = '123456' # to be replaced with Milenas seed
user1.save!

# Provider:
provider = Provider.new
provider.name = 'Test Provider'
provider.description = 'Test Description'
provider.category = 'Sports'
provider.provider_email = 'provider@gmail.com'
provider.save!

# My_Provider:
my_provider1 = MyProvider.new
my_provider1.user = user1
my_provider1.provider = provider
my_provider1.identifier_value = 'test value'
my_provider1.save!

# Update:
update1 = Update.new
update1.update_status = ['request not sent 🟡', 'pending 🟠', 'changed 🟢', 'declined 🔴'].sample
update1.provider = provider
update1.save!

puts "Done!"
puts "Created #{User.count} users."
puts "Created #{Provider.count} providers."
puts "Created #{MyProvider.count} my providers."
puts "Created #{Update.count} updates."
