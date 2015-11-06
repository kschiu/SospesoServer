class User < ActiveRecord::Base
  has_secure_password

  #relationships
  has_many :purchases
  has_many :cards

  #validations
  validates :first_name, :last_name, presence: true
  validates :email, uniqueness: true
  # validates_presence_of :password, on: :create 
  # validates_presence_of :password_confirmation, on: :create 
  validates_confirmation_of :password, message: "does not match"
  validates_length_of :password, minimum: 4, message: "must be at least 4 characters long", allow_blank: true

end
