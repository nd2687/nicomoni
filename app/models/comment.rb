# == Schema Information
#
# Table name: comments
#
#  id          :integer          not null, primary key
#  room_id     :integer          not null
#  user_id     :integer          not null
#  icon_number :integer          default(1), not null
#  author      :string(255)      not null
#  body        :string(255)      not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Comment < ActiveRecord::Base
  belongs_to :room
end
