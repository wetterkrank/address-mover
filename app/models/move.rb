class Move < ApplicationRecord
  has_many :updates, dependent: :destroy

  validates :moving_date, presence: true

end
