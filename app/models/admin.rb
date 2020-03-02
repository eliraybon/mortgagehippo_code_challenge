class Admin < User 
  before_validation do |admin|
    admin.type = "Admin"
  end
end