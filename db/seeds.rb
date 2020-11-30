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
user.email = 'user@gmail.com'
user.password = '123456'
user.first_name = "Anne"
user.last_name = "User"
user.phone_number = "078457838"
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

Provider.create(
  name: "Company X", 
  description: "Other services", 
  category: "Travel", 
  provider_email: "accounts@companyx.com",
  logo_url: "",
  identifier_name: "Customer number",
  update_method: "api",
  api_endpoint: "localhost:5000/account_update"
)

provider_array = []
identifier_name_array = ['Contract Number', 'Passport ID', 'Phone Number']

csv_text = File.read(Rails.root.join('lib', 'seeds_db', '20201124_categories_providers.csv'))
csv = CSV.parse(csv_text, :headers => true, :header_converters => :symbol)
csv.each do |row|
  # p row
  t = Provider.new
  t.name = row[:name]
  t.description = row[:description]
  t.category = row[:category]
  t.provider_email = row[:provider_email]
  t.logo_url = row[:image_url]
  t.identifier_name = identifier_name_array.sample
  t.save!
  provider_array << t
end

puts "- Created #{Provider.count} providers."

# My_Provider:

users_set = user_array.sample(rand(7..9))
users_set.each do |user|
  providers_set = provider_array.sample(rand(3..15))
  providers_set.each do |provider|
    MyProvider.create!(user: user, provider: provider)
  end
end

puts "- Created #{MyProvider.count} selections of providers (aka 'my providers')."

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
