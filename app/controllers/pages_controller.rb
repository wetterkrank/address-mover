class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home, :about ]

  def home
    # We can limit the number of results here and perhaps sort them by rating (if we have reviews)
    @providers = policy_scope(Provider).order(created_at: :asc).limit(4)
  end

  def about
  end
end
