class Provider < ApplicationRecord

  validates :name, presence: true
  validates :name, uniqueness: true
  validates :description, presence: true
  validates :category, presence: true
  validates :provider_email, presence: true
  validates :provider_email, uniqueness: true

end
