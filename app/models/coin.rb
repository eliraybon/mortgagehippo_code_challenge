class Coin < ApplicationRecord
  validates :name, :value, :quantity, presence: true 
  validates :name, uniqueness: true

  

end
