require 'rails_helper'

RSpec.describe Friendship, :type => :model do
  describe 'Factory' do
    example '定義が有効' do
      friendship = create(:friendship)
      friend = friendship.friend
      user = friendship.user
      expect(friendship).to be_valid
      expect(user).to be_valid
      expect(friend).to be_valid
    end
  end
end
