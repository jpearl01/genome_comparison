# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  fname      :string(255)
#  lname      :string(255)
#  email      :string(255)
#  username   :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ActiveRecord::Base
  attr_accessible :email, :fname, :lname, :username

  before_save { |user| user.email = email.downcase }

  validates :fname, presence: true, length: { maximum: 40 }
  validates :lname, presence: true, length: { maximum: 40 }
  validates :username, presence: true, length: { maximum: 40 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, 
  uniqueness: { case_sensitive: false }
  has_many :comparisons
end
