require 'rails_helper'

RSpec.describe SmsService do
  describe '#send' do
    it 'sends an sms' do
      sms_service = SmsService.new
      expect(sms_service.send('1234567890', 'Hello')).to eq('SMS sent')
    end
  end
end