class User < ApplicationRecord
  validates :username, uniqueness: true, presence: true
  validates :email, uniqueness: true, presence: true
  validates_presence_of :password

  has_secure_password

  def self.text_opt_in
    where(text_preference: true)
  end
end
