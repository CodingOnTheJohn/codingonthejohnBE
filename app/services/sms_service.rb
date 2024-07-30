class SmsService
  
  def self.send_sms(phone_number, message)
    @client = Twilio::REST::Client.new(Rails.application.credentials.twilio[:account_sid], Rails.application.credentials.twilio[:auth_token])
    @client.messages.create(
      from: Rails.application.credentials.twilio[:phone_number],
      to: phone_number,
      body: message
    )
  end
end