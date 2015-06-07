require 'rails_helper'

RSpec.describe Board, :type => :model do
  describe 'Factory' do
    example '定義が有効' do
      board = create(:board)
      expect(board).to be_valid
    end
  end
end
