class AutoconfirmJob < ApplicationJob
  queue_as :default

  def perform(update)
    update.update_status = Update::STATUS[2] # "confirmed"
    update.save!
  end
end
