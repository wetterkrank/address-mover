class Address < ApplicationRecord
  has_many :moves, dependent: :destroy
  belongs_to :user

  validates :street_name, presence: true
  validates :street_number, presence: true
  validates :zip, presence: true
  validates :city, presence: true

  def to_s
    "#{street_name}, #{street_number}, #{zip} #{city}"
  end
end
