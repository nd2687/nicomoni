# == Schema Information
#
# Table name: responses
#
#  id         :integer          not null, primary key
#  board_id   :integer          not null
#  name       :string(255)      not null
#  comment    :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Response < ActiveRecord::Base
  belongs_to :board
end
