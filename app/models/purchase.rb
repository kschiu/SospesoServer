class Purchase < ActiveRecord::Base
  # Relationships
  belongs_to :card
  belongs_to :user
  has_many :purchased_items
  has_many :items, through: :purchased_items

  # Scopes

  # Validations
  validates :card_id, :user_id, numericality: {greater_than_or_equal_to: 0, only_integer: true }
end
