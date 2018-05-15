class RegistrationMailer < ApplicationMailer
  def confirmation_email(user)
    @user = user
    mail(to: @user.email, subject: 'Battleshift Account Confirmation')
  end
end
