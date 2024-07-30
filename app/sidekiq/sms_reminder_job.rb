class SmsReminderJob
  include Sidekiq::Job

  def perform(users)
    users.each do |user|
      SmsService.send_sms(user.phone_number, "Hey! Don't forget to get your coding practice today!")
    end
  end
end
