require 'rails_helper'

RSpec.describe Response, :type => :model do
  describe "Factory" do
    example "定義が有効" do
      response = create(:response)
      expect(response).to be_valid
    end
  end
end
