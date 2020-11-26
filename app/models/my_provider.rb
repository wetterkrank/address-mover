class MyProvider < ApplicationRecord
  belongs_to :user
  belongs_to :provider

  validates :provider_id, uniqueness: { scope: :user_id, message: "must be unique for each user and provider" }
end
