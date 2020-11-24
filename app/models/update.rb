class Update < ApplicationRecord
  belongs_to :provider

  validates :update_status, presence: true

end
