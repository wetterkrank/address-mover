class Provider < ApplicationRecord
  has_many :my_providers, dependent: :destroy
  has_many :updates, dependent: :destroy

  validates :name, presence: true
  validates :name, uniqueness: true
  validates :description, presence: true
  validates :category, presence: true
  validates :provider_email, presence: true
  validates :provider_email, uniqueness: true

end
