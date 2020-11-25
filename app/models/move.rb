class Move < ApplicationRecord
  has_many :updates, dependent: :destroy
  belongs_to :user
  
  validates_presence_of :moving_date, :street_name, :street_number
  validates :zip, presence: true
  validates :city, presence: true
  
end
