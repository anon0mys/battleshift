require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of :email }
    it { should validate_presence_of :name }
    it { should validate_presence_of :password_digest }
  end
  describe 'callbacks' do
    it 'assigns api key to user upon creation' do
      user = create(:user)

      expect(user.api_key).to_not be_nil
    end
  end
end
