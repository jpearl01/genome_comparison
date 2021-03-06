# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  fname           :string(255)
#  lname           :string(255)
#  email           :string(255)
#  username        :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#

require 'spec_helper'

describe User do

  before { @user = User.new(fname: "Example", 
                            lname: "User", 
                            username: "euser", 
                            email: "user@example.com", 
                            password: "testpass", 
                            password_confirmation: "testpass") }

  subject { @user }

  it { should respond_to(:fname) }
  it { should respond_to(:lname) }
  it { should respond_to(:username) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest)}
  it { should respond_to( :password ) } 
  it { should respond_to( :password_confirmation) }
  it { should respond_to(:authenticate) }


  it { should be_valid }

  describe "When the first name isn't present" do
    before { @user.fname = "" }
    it {should_not be_valid }
  end

  describe "When the first name is too long" do
    before { @user.fname = "a" * 41 }
    it { should_not be_valid }
  end

  describe "When the last name isn't present" do
    before { @user.lname = "" }
    it {should_not be_valid }
  end

  describe "When the last name is too long" do
    before { @user.lname = "a" * 41 }
    it { should_not be_valid }
  end

  describe "When the username isn't present" do
    before { @user.username = "" }
    it {should_not be_valid }
  end

  describe "When the username is too long" do
    before { @user.username = "a" * 41 }
    it { should_not be_valid }
  end

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        @user.should_not be_valid
      end      
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        @user.should be_valid
      end      
    end
  end

  describe "When the email isn't present" do
    before { @user.email = "" }
    it {should_not be_valid }
  end

  describe "when email address is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end

    it { should_not be_valid }
  end

  describe "when password is not present" do
    before { @user.password = @user.password_confirmation = " " }
    it { should_not be_valid }
  end

  describe "when password doesn't match confirmation" do
    before { @user.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end

  describe "when password confirmation is nil" do
    before { @user.password_confirmation = nil }
    it { should_not be_valid }
  end

  describe "return value of authenticate method" do
    before { @user.save }
    let(:found_user) { User.find_by_email(@user.email) }
    
    describe "with valid password" do
      it { should == found_user.authenticate(@user.password) }
    end
    
    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }
      
      it { should_not == user_for_invalid_password }
      specify { user_for_invalid_password.should be_false }
    end
  end

  describe "with a password that's too short" do
    before { @user.password = @user.password_confirmation = "a" * 5 }
    it { should be_invalid }
  end

end

