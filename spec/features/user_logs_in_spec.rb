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

    scenario 'activates account through email activation link' do
      user = create(:user)
      expect(user.status).to eq 'inactive'

      page.driver.put(activation_path(user), { authentication: { token: '12345' } })

      expect(current_path).to eq(activation_path(user))
      expect(page).to have_content 'Thank you! Your account is now activated.'

      click_on 'Dashboard'

      expect(current_path).to eq(dashboard_path)
      expect(page).to_not have_content('This account has not yet been activated. Please check your email.')
      expect(page).to have_content('Status: Active')
    end
  end
end
