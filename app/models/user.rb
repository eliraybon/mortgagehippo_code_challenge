class User < ApplicationRecord
  after_initialize :ensure_api_key

  def self.generate_api_key
    SecureRandom.base64.tr('+/=', 'Qrt')
  end

  def ensure_api_key
    self.api_key = User.generate_api_key

    while (User.exists?(api_key: self.api_key))
      self.api_key = User.generate_api_key
    end

    self.api_key
  end

end
