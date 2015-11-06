class Card < ActiveRecord::Base
  #relationship
  belongs_to :user

  #validations
  validates :card_number, :holder_name, :expiration_date, :csv_code, presence: true
  validates :zip_code, presence: true, format: { with: /\A\d{5}\z/, message: "Should be five digits long", allow_blank: true }
  validates :user_id, numericality: {only_integer: true, greater_than_or_equal_to: 0}

end
