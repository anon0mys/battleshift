require 'rails_helper'

feature 'user logs in' do
  context 'and registers for the first time' do
    scenario 'and gets to dashboard with not activated message' do
      visit '/'
      click_on 'Register'

      expect(current_path).to eq('/register')

      fill_in 'user[name]', with: 'TestName'
      fill_in 'user[email]', with: 'Test@mail.com'
      fill_in 'user[password]', with: 'password'
      fill_in 'user[password_confirmation]', with: 'password'
      click_on 'submit'

      expect(current_path).to eq('/dashboard')
      expect(page).to have_content('Logged in as TestName')
      expect(page).to have_content('This account has not yet been activated. Please check your email.')
    end

    scenario 'and activates account through email activation link' do
      visit register_path

      fill_in 'user[name]', with: 'Name'
      fill_in 'user[email]', with: 'Test@mail.com'
      fill_in 'user[password]', with: 'password'
      fill_in 'user[password_confirmation]', with: 'password'
      click_on 'submit'

      email = ActionMailer::Base.deliveries.last
      expect(email.to.first).to eq('Test@mail.com')

      user = User.find_by(name: 'Name')

      visit activation_path(user.id)

      expect(current_path).to eq(activation_path(user))
      expect(page).to have_content 'Thank you! Your account is now activated.'

      click_on 'Dashboard'

      expect(current_path).to eq(dashboard_path)
      expect(page).to_not have_content('This account has not yet been activated. Please check your email.')
      expect(page).to have_content('Status: Active')
    end
  end

  context 'attempts to register with bad information' do
    scenario 'and is redirected to register path with flash error message' do
      visit '/'
      click_on 'Register'

      expect(current_path).to eq('/register')

      fill_in 'user[name]', with: 'TestName'
      fill_in 'user[email]', with: 'Test@mail.com'
      fill_in 'user[password]', with: 'password'

      click_on 'submit'

      expect(current_path).to eq('/register')
      expect(page).to have_content('Registration unsuccessful')
    end
  end
end
