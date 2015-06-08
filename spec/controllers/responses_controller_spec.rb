require 'rails_helper'

RSpec.describe ResponsesController, :type => :controller do
  let!(:user) { create(:user) }
  let!(:board) { create(:board) }

  before do
    session[:current_user_id] = user.id
  end
  describe 'Response' do
    it 'Success create Response' do
      params = { "response"=>{"comment"=>"NEWCOMMENT"}, "board_id" => board.id }
      post :create, params

      expect(1).to eq(board.responses.size)
      expect("NEWCOMMENT").to eq(board.responses.last.comment)
    end
  end
end
