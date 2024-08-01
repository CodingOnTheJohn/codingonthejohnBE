require 'rails_helper'

RSpec.describe SmsService, type: :service do
  describe '.send_sms' do
    let(:phone_number) { '+1234567890' }
    let(:message) { 'Test message' }
    let(:twilio_client_double) { double('Twilio::REST::Client') }
    let(:messages_double) { double('Twilio::REST::Api::V2010::AccountContext::MessageList') }

    before do
      allow(Twilio::REST::Client).to receive(:new).and_return(twilio_client_double)
      allow(twilio_client_double).to receive(:messages).and_return(messages_double)
      allow(messages_double).to receive(:create)
    end

    it 'sends an SMS with the correct parameters' do
      SmsService.send_sms(phone_number, message)

      expect(Twilio::REST::Client).to have_received(:new).with(
        Rails.application.credentials.twilio[:account_sid],
        Rails.application.credentials.twilio[:auth_token]
      )

      expect(messages_double).to have_received(:create).with(
        from: Rails.application.credentials.twilio[:phone_number],
        to: phone_number,
        body: message
      )
    end
  end
end