require 'csv'

puts 'Cleaning database now...'
Move.destroy_all
p Move.all
Address.destroy_all
p Address.all
MyProvider.destroy_all
User.destroy_all
p User.all
Update.destroy_all
Provider.destroy_all
puts 'Database clean ✅'
puts 'Creating seeds - unfortunately takes a bit ... 😒'

# Users: 1x Admin, 1x LogIn User, 10x 'Real Users'

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

puts "Created #{User.count} users."

# Provider:

provider_array = []

csv_text = File.read(Rails.root.join('lib', 'seeds_db', '20201124_categories_providers.csv'))
csv = CSV.parse(csv_text, :headers => true, :header_converters => :symbol)
csv.each do |row|
  # p row
  t = Provider.new
  t.name = row[:name]
  t.description = row[:description]
  t.category = row[:category]
  t.provider_email = row[:provider_email]
  t.save!
  provider_array << t
end

puts "Created #{Provider.count} providers."

# My_Provider:

100.times do
MyProvider.create!(
  user: user_array.sample,
  provider: provider_array.sample,
# my_provider.identifier_value = 'test value'
)
end

puts "Created #{MyProvider.count} selections of providers (aka 'my providers')."

# Address:

address_array = []

csv_text = File.read(Rails.root.join('lib', 'seeds_db', '20201124_addresses.csv'))
csv = CSV.parse(csv_text, :headers => true, :header_converters => :symbol)
csv.each do |row|
  # p row
  t = Address.new
  t.street_name = row[:street_name]
  t.street_number = row[:street_number]
  t.zip = row[:zip]
  t.city = row[:city]
  t.user = user_array.sample
  t.save!
  address_array << t
end

puts "Created #{Address.count} addresses."

# Move:

move_array = []

11.times do
  random_day = rand(1..28)
  random_month = rand(1..12)

  move_array << Move.create!(
    moving_date: DateTime.new(2020, random_month, random_day),
    address: address_array.sample,
  )
end

puts "Created #{Move.count} moves."

# Update:

11.times do
  Update.create!(
    update_status: ['request not sent', 'pending', 'changed', 'declined'].sample,
    provider: provider_array.sample,
    move: move_array.sample,
  )
end

puts "Created #{Update.count} updates."

puts "All done! 😎👍✅"
