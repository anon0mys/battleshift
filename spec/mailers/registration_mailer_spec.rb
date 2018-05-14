require "rails_helper"

RSpec.describe RegistrationMailer, type: :mailer do
  describe 'sends confirmation email' do
    from = 'me@example.com'
    to = 'to@example.com'
    email = RegistrationMailer.confirmation_email(from, to)

    expect(email.deliver_now).to eq(1)

    expect(email.from).to eq(from)
    expect(email.to).to eq(to)
    expect(email.subject).to eq('Battleshift Account Confirmation')
    expect(email.body.to_s).to eq(read_fixture('confirmation_email').join)
  end
end
