class User < ApplicationRecord
  validates_presence_of :name, :email, :api_key
  validates_uniqueness_of :api_key
  validates_presence_of :password_digest, on: :create
  validates :password_digest, confirmation: {case_sensitive: true}
  has_secure_password
  enum status: ['inactive', 'active']

  def set_api_key
    self.api_key = ApiKey.generate
  end
end
