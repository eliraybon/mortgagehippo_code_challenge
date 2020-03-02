class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :coin

  # this makes sure that the 'type' column is included in JSON responses 
  def serializable_hash(options=nil)
    super.merge "type" => type
  end
end
