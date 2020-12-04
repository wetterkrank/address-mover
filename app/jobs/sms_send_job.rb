class SmsSendJob < ApplicationJob
  queue_as :default

  def perform(update)
    auth_string = ENV['CLICKSEND_BASIC_AUTH']

    uri = URI("https://rest.clicksend.com/v3/sms/send")
    headers = {
      'Content-Type': 'application/json', 
      'Accept': 'application/json',
      'Authorization': "Basic #{auth_string}"
    }

    data = {
      "messages": [
        {
          "body": "Hola! This is AddressMover; we've sent your paper mail.", # We can add the provider name here
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
    end
  end
end
