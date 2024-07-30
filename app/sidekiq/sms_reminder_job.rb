class SmsReminderJob
  include Sidekiq::Job

  def perform
    User.text_opt_in.each do |user|
      SmsService.send_sms(user.phone_number, "Hey! Don't forget to get your coding practice today!")
    end
  end
end
