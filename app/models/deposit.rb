class Deposit < Transaction 
  before_validation do |deposit|
    deposit.type = "Deposit"
  end
end