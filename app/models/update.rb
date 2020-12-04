class Update < ApplicationRecord
  STATUS = ['not sent', 'sent, but not yet confirmed', 'confirmed', 'declined, please refer to the letter', 'sent by post']

  belongs_to :provider
  belongs_to :move
  has_one :pdf, dependent: :destroy
  has_one :user, through: :move

  validates :update_status, presence: true
  validates :update_status, inclusion: { in: STATUS, message: "not a valid status" }
  validates :provider_id, uniqueness: { scope: :move_id, message: "must be unique for each move and provider" }
end
