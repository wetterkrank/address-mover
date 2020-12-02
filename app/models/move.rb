class Move < ApplicationRecord
  has_many :updates, dependent: :destroy
  belongs_to :user
  has_many :providers, through: :updates

  validates_presence_of :moving_date, :street_name, :street_number
  validates :zip, presence: true
  validates :city, presence: true

  geocoded_by :street_name
  geocoded_by :street_number
  after_validation :geocode, if: :will_save_change_to_street_name?
  after_validation :geocode, if: :will_save_change_to_street_number?

  def address_string
    "#{street_name}, #{street_number}, #{zip}, #{city}"
  end
end
