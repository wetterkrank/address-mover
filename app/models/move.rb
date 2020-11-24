class Move < ApplicationRecord
  has_many :updates, dependent: :destroy
  belongs_to :user
  belongs_to :address, dependent: :destroy

  validates :moving_date, presence: true
end
