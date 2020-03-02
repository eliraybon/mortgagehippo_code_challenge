class Coin < ApplicationRecord
  validates :name, :value, :quantity, presence: true 
  validates :name, uniqueness: true

  def self.total 
    total = 0
    Coin.all.each do |coin|
      total += coin.quantity * coin.value 
    end
    # format response in dollars 
    "$#{'%.2f' % (total.to_f / 100)}"
  end

end
