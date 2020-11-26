class Update < ApplicationRecord
  belongs_to :provider
  belongs_to :move

  validates :update_status, presence: true
  validates :provider_id, uniqueness: { scope: :move_id,  message: "Must be unique for each move and provider" }
  
end
