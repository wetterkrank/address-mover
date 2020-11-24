class Move < ApplicationRecord
    validates :moving_date, presence: true
end
