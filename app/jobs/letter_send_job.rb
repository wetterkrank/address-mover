class LetterSendJob < ApplicationJob
  queue_as :default

  def perform(update)
    auth_string = ENV['CLICKSEND_BASIC_AUTH']

    p update.pdf.url
    logger.debug update.pdf.url

    uri = URI("https://rest.clicksend.com/v3/post/letters/send")
    headers = { 
      'Content-Type': 'application/json', 
      'Accept': 'application/json',
      'Authorization': "Basic #{auth_string}"
    }

    data = {
      "file_url": "https://escapefromberl.in/Address%20Change%20Notification.pdf",
      "colour": 0,
      "recipients": [
        {
          "return_address_id": 110541,
          "schedule": 0,
          "address_postal_code": "11111",
          "address_country": "DE",
          "address_line_1": "#{update.move.street_name} #{update.move.street_number}",
          "address_state": "Berlin",
          "address_name": "Le Wagon Test",
          "address_line_2": "",
          "address_city": "Berlin"
        }
      ],
      "template_used": 0,
      "duplex": 0,
      "priority_post": 0
    }

    Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      request = Net::HTTP::Post.new uri, headers
      request.body = data.to_json
      response = http.request request # Net::HTTPResponse object

      logger.debug "API HTTP response code: #{response.code}"
      logger.debug JSON.parse response.body

      if response.code == "200"
        update.update_status = Update::STATUS[1] # "pending"
      else
        update.update_status = Update::STATUS[0] # "not sent"
      end
      update.save!
    end
  end
end
