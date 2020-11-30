class Provider < ApplicationRecord
  CATEGORY = [
    "Banking & Insurance",
    "Charity",
    "Communication",
    "Energy",
    "Food",
    "Health",
    "Shopping",
    "Sports",
    "Travel"
  ]

  has_many :my_providers, dependent: :destroy
  has_many :updates, dependent: :destroy

  validates :name, presence: true
  validates :name, uniqueness: true
  validates :description, presence: true
  validates :category, presence: true
  validates :category, inclusion: { in: CATEGORY, message: "Not a valid category" }
  validates :provider_email, presence: true
  validates :provider_email, uniqueness: true

  include PgSearch::Model
    pg_search_scope :search_by_name,
      against: [ :name ],
      using: {
        tsearch: { prefix: true }
      }

end
