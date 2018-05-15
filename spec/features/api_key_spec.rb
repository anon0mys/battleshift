require 'rails_helper'

describe ApiKey do
  context 'class methods' do
    it '.generate' do
      expect(ApiKey.generate).to be_a String
    end
  end
end
