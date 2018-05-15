require "rails_helper"

RSpec.describe RegistrationMailer, type: :mailer do
  it 'sends confirmation email' do
    user = create(:user, email: 'test@mail.com')
    expected_body = 'Visit here to activate your account.'
    expected_url = 'localhost:3000/activate'

    email = described_class.confirmation_email(user).deliver_now

    expect(email.to.first).to eq(user.email)
    expect(email.subject).to eq('Battleshift Account Confirmation')
    expect(email.html_part.body.to_s).to include(expected_body)
    expect(email).to have_link('here', href: expected_url)
  end
end
