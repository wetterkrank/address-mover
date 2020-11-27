class MyProvider < ApplicationRecord
  belongs_to :user
  belongs_to :provider

  validates :provider_id, uniqueness: { scope: :user_id, message: "selection must be unique for the user" }
end
