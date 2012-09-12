# == Schema Information
#
# Table name: comparisons
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Comparison < ActiveRecord::Base
  attr_accessible :title, :user_id
  validates :title, length: {maximum: 140}
  belongs_to :user
end
