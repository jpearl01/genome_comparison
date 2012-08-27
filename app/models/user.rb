class User < ActiveRecord::Base
  attr_accessible :email, :fname, :lname, :username
  has_many :comparisons
end
