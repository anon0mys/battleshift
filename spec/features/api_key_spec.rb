require 'rails_helper'

describe ApiKey do
  
  subject { ApiKey.new }

  context 'class methods' do
    it '.generate' do
      expect(subject.generate).to be_a String
    end
  end
end
