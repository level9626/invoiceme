# Use this hook to configure devise mailer, warden hooks and so forth.
# Many of these configuration options can be set straight in your model.
Devise.setup do |config|
  config.secret_key = '903ef6562b3915466eac990353582f4d63deff6022a17ea7b06febc8f98ee13574c6f540151ff82f986cc8d8df11fcd3c24bd8068bff9807af3ab7c8b6f858cf'
  
  config.mailer_sender = 'no-reply@' + Rails.application.secrets.domain_name

  require 'devise/orm/active_record'

  config.case_insensitive_keys = [:email]
  config.strip_whitespace_keys = [:email]
  config.skip_session_storage = [:http_auth]
  config.stretches = Rails.env.test? ? 1 : 10
  config.reconfirmable = true
  config.expire_all_remember_me_on_sign_out = true
  config.password_length = 8..128
  config.reset_password_within = 6.hours
  config.sign_out_via = :delete
end
