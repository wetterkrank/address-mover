class Update < ApplicationRecord
  belongs_to :provider
  belongs_to :move

  validates :update_status, presence: true
  
end
