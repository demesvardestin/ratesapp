# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

require 'carrierwave'
require 'carrierwave/orm/activerecord'

ActionMailer::Base.smtp_settings = {
  :user_name => "demo07",
  :password => "Knowledge1!",
  :domain => "action-cable-chat-demo07.c9users.io/",
  :address => 'smtp.sendgrid.net',
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}