require 'rails_helper'

RSpec.describe UserSerializer, type: :serializer do
  describe 'serialized JSON' do
    let(:user) { User.create!(email: 'test@example.com', username: 'testuser', password: 'testtest') }
    let(:serialized_user) { UserSerializer.new(user).serializable_hash }

    it 'includes the expected attributes' do
      expect(serialized_user[:data][:attributes]).to include(
        email: 'test@example.com',
        username: 'testuser',
        id: user.id
      )
    end

    it 'passes correct data' do
      expect(serialized_user[:data][:id]).to eq("#{user.id}")
      expect(serialized_user[:data][:type]).to eq(:user)
    end
  end
end