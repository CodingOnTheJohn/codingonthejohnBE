require 'sidekiq'
require 'sidekiq-cron'

Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://localhost:6379/0' }
end

Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://localhost:6379/0' }
end

schedule = {
  'sms_reminder' => {
    'class' => 'SmsReminderJob',
    'cron' => '0 12 * * *',
    'queue' => 'default'
  }
}

Sidekiq::Cron::Job.load_from_hash(schedule)