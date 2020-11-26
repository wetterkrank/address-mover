class Update < ApplicationRecord
  STATUS = ['request not sent', 'pending', 'changed', 'declined']

  belongs_to :provider
  belongs_to :move
  has_one :user, through: :move

  validates :update_status, presence: true
  validates :provider_id, uniqueness: { scope: :move_id, message: "must be unique for each move and provider" }
end
