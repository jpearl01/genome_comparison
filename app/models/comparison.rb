class Comparison < ActiveRecord::Base
  attr_accessible :title, :user_id
  validates :title, length: {maximum: 140}
  belongs_to :user
end
