require 'rails_helper'

RSpec.describe Friendship, :type => :model do
  describe 'Factory' do
    example '定義が有効' do
      friendship = create(:friendship)
      expect(friendship).to be_valid
    end
  end
end
