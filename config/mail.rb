if Rails.env.development?
  ActionMailer::Base.delivery_method = :letter_opener
end

if Rails.env.test?
  ActionMailer::Base.delivery_method = :test
end

if Rails.env.production?
  ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.smtp_settings = {
    address: 'smtp.gmail.com',
    domain: 'gmail.com',
    port: 587,
    user_name: ENV('MAIL_USERNAME'),
    password:  ENV('MAIL_PASSWORD'),
    authentication: 'plain',
    enable_starttls_auto: true
  }
end

