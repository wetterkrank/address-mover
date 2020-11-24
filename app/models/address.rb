class Address < ApplicationRecord
    validates :city, presence: true
    validates :street_number, presence: true
    validates :street_name, presence: true
    validates :zip, presence: true
end
