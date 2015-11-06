class Card < ActiveRecord::Base
  #relationship
  belongs_to :user

  #validations
  validates :user_id, :card_number, :holder_name, :expiration_month, :expiration_year, :csv_code, presence: true
  validates :zip_code, presence: true, format: { with: /\A\d{5}\z/, message: "Should be five digits long", allow_blank: true }

end
