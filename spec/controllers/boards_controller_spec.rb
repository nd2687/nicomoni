require 'rails_helper'

RSpec.describe BoardsController, :type => :controller do
  let(:user) { create(:user) }

  before do
    session[:current_user_id] = user.id
  end

  describe 'Board' do
    it 'Success create Board' do
      params = { "board"=>{"title"=>"BOARDTITLE"} }
      post :create, params

      expect(1).to eq(Board.count)
      expect("BOARDTITLE").to eq(Board.last.title)
    end
  end
end
