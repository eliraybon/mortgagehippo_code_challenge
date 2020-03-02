class Withdrawal < Transaction 
  before_validation do |withdrawal|
    withdrawal.type = "Withdrawal"
  end
end