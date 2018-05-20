require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.create!(name: 'mario', email: 'itsame@mail.com', password: 'password', api_key: '12345') }

  describe 'validations' do
    it { should validate_presence_of :email }
    it { should validate_presence_of :name }
    it { should validate_presence_of :password_digest }
    # it { should validate_presence_of :api_key }

  end

  describe 'user status' do
    it 'should have a default status of inactive' do
      expect(subject.status).to eq 'inactive'
    end

    it 'can be set to active' do
      subject.update(status: 'active')

      expect(subject.status).to eq 'active'
    end
  end
end
