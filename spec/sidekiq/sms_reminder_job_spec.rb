require 'rails_helper'
RSpec.describe SmsReminderJob, type: :job do
  describe '#perform' do
    it 'sends a text message to all users who have opted in' do
      user_1 = User.create!(username: 'user_1', email: 'test1@test.com', password: 'password', text_preference: true, phone_number: '123-456-7890')

      allow(SmsService).to receive(:send_sms).with(user_1.phone_number, "Hey! Don't forget to get your coding practice today!")

      SmsReminderJob.new.perform

      expect(SmsService).to have_received(:send_sms).with(user_1.phone_number, "Hey! Don't forget to get your coding practice today!")
    end
  end
end
