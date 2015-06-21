# == Schema Information
#
# Table name: boards
#
#  id         :integer          not null, primary key
#  title      :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Board < ActiveRecord::Base
  has_many :responses
end
