module ApiKey
  def self.generate
    SecureRandom.base64.tr('+,/', 'aBc')
  end
end
