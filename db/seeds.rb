require 'csv'
require 'date'

puts 'Cleaning database now...'
puts "" 
puts "🔴 Moves:"
Move.destroy_all
p Move.all

puts "🔴 Users:"
User.destroy_all
p User.all

puts "🔴 My Providers:" 
MyProvider.destroy_all
p MyProvider.all

puts "🔴 Updates:" 
Update.destroy_all
p Update.all

puts "🔴 Providers:" 
Provider.destroy_all
p Provider.all
puts "" 
puts 'Database clean ✅'
puts "" 
puts 'Creating seeds - unfortunately takes a bit ... 😒'


# User: 1x Admin, 1x LogIn User, 10x 'Real Users'

admin = User.new	
admin.email = 'admin@gmail.com'	
admin.password = '123456'	
admin.first_name = "Bob"	
admin.last_name = "Admin"	
admin.phone_number = "070723573"
admin.admin = true
admin.birthday = DateTime.new(1993, 02, 01)	
admin.save!

user_array = []

user = User.new
user.email = 'c.k@gmail.com'
user.password = '123456'
user.first_name = "Christoph"
user.last_name = "Kuhlkid"
user.phone_number = "+4915906375709"
user.birthday = DateTime.new(1994, 03, 02)
user.save!
user_array << user

csv_text = File.read(Rails.root.join('lib', 'seeds_db', '20201124_users.csv'))
csv = CSV.parse(csv_text, :headers => true, :header_converters => :symbol)
csv.each do |row|
  t = User.new
  t.email = row[:email]
  t.password = row[:password]
  t.first_name = row[:first_name]
  t.last_name = row[:last_name]
  t.phone_number = row[:phone_number]
  t.birthday = row[:birthday]
  t.save!
  user_array << t
end

puts "- Created #{User.count} users."


# Provider:

address_csv_text = File.read(Rails.root.join('lib', 'seeds_db', '20201124_addresses.csv'))
address_csv = CSV.parse(address_csv_text, :headers => true, :header_converters => :symbol)

csv_text = File.read(Rails.root.join('lib', 'seeds_db', '20201124_categories_providers.csv'))
csv = CSV.parse(csv_text, :headers => true, :header_converters => :symbol)
csv.each do |row|
  t = Provider.new
  t.name = row[:name]
  t.description = row[:description]
  t.category = row[:category]
  t.provider_email = row[:provider_email]
  t.logo_url = row[:image_url]

  address = address_csv[rand(address_csv.length)]
  t.street_name = address[:street_name]
  t.street_number = address[:street_number]
  t.zip = address[:zip]
  t.city = address[:city]
  t.save!
end

# Adding some required data for 1st provider in each category %-)

identifier_name_array = ['Contract number', 'Passport number', 'Membership card ID', 'Account number']

providers = Provider.all
Provider::CATEGORY.each do |cat_name|
  provider = providers.filter { |prov| prov.category == cat_name }.first
  p provider.name
  provider.identifier_name = identifier_name_array.sample
  provider.save!
end

# This is our special provider, adding it here so the random doesn't mess it up

Provider.create(
  name: "Travel Dream", 
  description: "Other services", 
  category: "Travel", 
  provider_email: "accounts@traveldream.com",
  logo_url: "https://res.cloudinary.com/dzokjumuf/image/upload/v1606914426/Address-Mover-Logos/travel_dream_oxa3um.png",
  identifier_name: "Customer number",
  update_method: "api",
  api_endpoint: "http://some-company.herokuapp.com/update"
)

puts "- Created #{Provider.count} providers."


# My_Provider:

# provider_array = Provider.all
# users_set = user_array.sample(rand(7..9))
# users_set.each do |user|
#   providers_set = provider_array.sample(rand(3..7))
#   providers_set.each do |provider|
#     MyProvider.create!(user: user, provider: provider)
#   end
# end

# puts "- Created #{MyProvider.count} selections of providers (aka 'my providers')."


# Move:

# move_array = []

# csv_text = File.read(Rails.root.join('lib', 'seeds_db', '20201124_addresses.csv'))
# csv = CSV.parse(csv_text, :headers => true, :header_converters => :symbol)
# csv.each do |row|
#   random_day = rand(1..28)
#   random_month = rand(1..12)
#   t = Move.new
#   t.moving_date = DateTime.new(2020, random_month, random_day)
#   t.street_name = row[:street_name]
#   t.street_number = row[:street_number]
#   t.zip = row[:zip]
#   t.city = row[:city]
#   t.user = user_array.sample
#   t.save!
#   move_array << t
# end

puts "- Created #{Move.count} moves."


# Update:

# 10.times do
#   Update.create!(
#     update_status: Update::STATUS.sample,
#     provider: provider_array.sample,
#     move: move_array.sample,
#   )
# end

puts "- Created #{Update.count} updates."

puts "All done! 😎👍✅"
