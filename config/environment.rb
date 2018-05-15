# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

# Configuration for sendgrid smtp servers
# ActionMailer::Base.smtp_settings = {
#   user_name: ENV['SENDGRID_USERNAME'],
#   password: ENV['SENDGRID_PASSWORD'],
#   domain: 'safe-beyond-34266.herokuapp.com',
#   address: 'smtp.sendgrid.net',
#   port: 587,
#   authentication: :plain,
#   enable_starttls_auto: true
# }
