require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:username) }
    it { should validate_uniqueness_of(:username) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:password) }
  end

  describe 'class methods' do
    it '#text_opt_in' do
      user_1 = User.create!(username: 'user_1', email: 'test1@test.com', password: 'password', text_preference: true, phone_number: '123-456-7890')
      user_2 = User.create!(username: 'user_2', email: 'test2@test.com', password: 'password', text_preference: true, phone_number: '123-456-7890')
      user_3 = User.create!(username: 'user_3', email: 'test3@test.com', password: 'password', text_preference: false, phone_number: '123-456-7890')

      expect(User.text_opt_in).to match_array([user_1, user_2])
      expect(User.text_opt_in).not_to include(user_3)
      expect(User.text_opt_in.count).to eq(2)
    end
  end
end
