class User < ApplicationRecord
  validates :email, :api_key, presence: true, uniqueness: true 
  validates :type, presence: true 

  after_initialize :ensure_api_key

  # has_many :transactions 

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
