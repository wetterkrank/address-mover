class SmsSendJob < ApplicationJob
  queue_as :default

  def perform(update)
    auth_string = ENV['CLICKSEND_BASIC_AUTH']

    pdf_url = update.pdf.url
    logger.debug pdf_url
    # p pdf_url

    uri = URI("https://rest.clicksend.com/v3/sms/send")
    headers = { 
      'Content-Type': 'application/json', 
      'Accept': 'application/json',
      'Authorization': "Basic #{auth_string}"
    }

    data = {
      "messages": [
        {
          "body": "Hola! This is AddressMover; we've sent your paper mail.",
          "to": update.move.user.phone_number, # "+491721901502", # update.move.user.phone_number,
          "from": "+491721901502"
        }
      ]
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
