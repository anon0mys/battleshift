class User < ApplicationRecord
  validates_presence_of :name, :email, :password_digest, :api_key
  validates_uniqueness_of :api_key
  validates :password_digest, confirmation: {case_sensitive: true}
  has_secure_password
  enum status: ['inactive', 'active']

  before_validation :set_api_key

  private

    def set_api_key
      self.api_key = ApiKey.generate
    end
end
