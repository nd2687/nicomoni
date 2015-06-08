require 'rails_helper'

RSpec.describe FriendshipsController, :type => :controller do
  let!(:user1) { create(:user) }
  let!(:user2) { create(:user) }

  before do
    session[:current_user_id] = user1.id
  end

  describe 'Friendship' do
    it 'Friendship create and destroy' do
      params = { "user_id" => user2.id }
      post :create, params

      expect(1).to eq(user1.friends.size)
      expect(user1).to eq(Friendship.last.user)
      expect(user2).to eq(Friendship.last.friend)

      params = { "user_id" => user2.id, "id" => Friendship.last.id }
      delete :destroy, params

      expect(0).to eq(user1.friends.size)
      expect(0).to eq(Friendship.count)
    end
  end
end
