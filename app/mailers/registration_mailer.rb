class RegistrationMailer < ApplicationMailer
  def confirmation_email(user)
    mail(to: user.email, subject: 'Battleshift Account Confirmation')
  end
end
