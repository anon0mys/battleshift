require "rails_helper"

RSpec.describe RegistrationMailer, type: :mailer do
  it 'sends confirmation email' do
    user = create(:user, email: 'test@mail.com')
    expected_body = 'Visit here to activate your account.'

    email = described_class.confirmation_email(user).deliver_now

    expect(email.to.first).to eq(user.email)
    expect(email.subject).to eq('Battleshift Account Confirmation')
    expect(email.body.to_s).to eq(expected_body)
  end
end
