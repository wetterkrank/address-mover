class LetterSendJob < ApplicationJob
  queue_as :default

  def perform(update)
    auth_string = ENV['CLICKSEND_BASIC_AUTH']

    pdf_url = update.pdf.url
    logger.debug pdf_url
    # p pdf_url

    uri = URI("https://rest.clicksend.com/v3/post/letters/send")
    headers = { 
      'Content-Type': 'application/json', 
      'Accept': 'application/json',
      'Authorization': "Basic #{auth_string}"
    }

    data = {
      "file_url": pdf_url, # "https://escapefromberl.in/Address%20Change%20Notification.pdf",
      "colour": 0,
      "recipients": [
        {
          "return_address_id": 110541, # Alex's address in ClickSend address book
          "schedule": 0,
          "address_postal_code": "11111", # "11111" is the special test postcode, to be replaced by update.provider.zip
          "address_country": "DE",
          "address_line_1": "#{update.provider.street_name} #{update.provider.street_number}",
          "address_state": "Berlin",
          "address_name": update.provider.name,
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
        update.update_status = Update::STATUS[2] # 1 - pending, 2 - confirmed
      else
        update.update_status = Update::STATUS[3] # 0 - not sent yet; IF YOU USE 0, fix the updates.new? method
      end
      update.save!
    end
  end
end
