class Purchase < ActiveRecord::Base
  #relationships
  belongs_to :card
  belongs_to :user

  #validations
  validates :card_id, :user_id, numericality: {greater_than_or_equal_to: 0, only_integer: true }
end
