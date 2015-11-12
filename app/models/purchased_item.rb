class PurchasedItem < ActiveRecord::Base
  # Relationships
  belongs_to :purchase
  belongs_to :item
  belongs_to :buyer, :class_name => "User", :foreign_key => "buyer_id"
  belongs_to :redeemer, :class_name => "User", :foreign_key => "redeemer_id"

  # Scopes

  # Validations
end
