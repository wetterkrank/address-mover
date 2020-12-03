class PDF < ApplicationRecord
  # belongs_to :update
  # NB: can't do the above, it conflicts with .update method
  # We'll be using .parent to refer to its Update
  belongs_to :parent, foreign_key: "update_id", class_name: "Update"

  def url
    # host must be set in the development/production.rb
    Rails.application.routes.url_helpers.pdf_url("#{uuid}.pdf")
  end
end
