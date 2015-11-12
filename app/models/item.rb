class Item < ActiveRecord::Base
  # Relationships
  has_many :purchased_items
  has_many :purchases, through: :purchased_items
  belongs_to :store

  # Scopes
  # Validations
end
