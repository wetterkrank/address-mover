class MyProvider < ApplicationRecord
  belongs_to :user
  belongs_to :provider

  # validates :user_id, presence: true
  validates :provider_id, presence: true

end
