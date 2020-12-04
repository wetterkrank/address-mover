class AutodeclineJob < ApplicationJob
  queue_as :default

  def perform(update)
    update.update(update_status: Update::STATUS[3]) # "declined"
    PDF.create(parent: update, uuid: SecureRandom.uuid)
  end
end
