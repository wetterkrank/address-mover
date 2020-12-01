class ApiSendJob < ApplicationJob
  queue_as :default

  def perform(update)

    sleep 10

    uri = URI(update.provider.api_endpoint)
    header = { 'Content-Type': 'application/json', 'Accept': 'application/json' }
    data = {
      user: {
        customer_number: update.id_sent,
        street_name: update.move.street_name,
        street_number: update.move.street_number,
        zip: update.move.zip,
        city: update.move.city
      }
    }

    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Patch.new(uri, header)
    request.body = data.to_json
    response = http.request(request)
    logger.debug "API HTTP response code: #{response.code}"
    logger.debug update.class

    if response.code == "200"
      update.update_status = Update::STATUS[2] # "changed"
    else
      update.update_status = Update::STATUS[3] # "declined"
    end
    update.save!
  end

end
