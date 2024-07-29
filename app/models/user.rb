class User < ApplicationRecord
  validates :username, uniqueness: true, presence: true
  validates :email, uniqueness: true, presence: true
  validates_presence_of :password

  has_secure_password

  def self.from_github(auth)
    User.find_or_create_by(provider: auth['provider'], uid: auth['uid']) do |user|
      user.username = auth['info']['nickname']
      user.email = auth['info']['email']
      user.password = SecureRandom.hex(10)
    end
  end
end
