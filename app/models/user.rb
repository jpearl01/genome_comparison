class User < ActiveRecord::Base
  attr_accessible :email, :fname, :lname, :username
end
