require 'spec_helper'

describe User do
  before do
    @user = build(:user)
  end

  describe "validations" do
    it "is valid" do
      @user.should be_valid
    end
  end

  describe ".to_s" do
    it "returns the username" do
      @user.username = Faker::Internet.user_name
      @user.to_s.should == @user.username
    end
  end

  describe "#find_first_by_auth_conditions" do
    context "when username provided" do
      it "finds the user" do
        @user.password = "please"
        @user.save!
        User.find_first_by_auth_conditions(username: @user.username).should == @user
      end
    end

    context "when email provided" do
      it "finds the user" do
        @user.password = "please"
        @user.save!
        User.find_first_by_auth_conditions(email: @user.email).should == @user
      end
    end

    context "when login is invalid" do
      it "does not find the user" do
        User.find_first_by_auth_conditions(email: "random@foo.org").should be_nil
      end
    end

  end #find_first_by_auth_conditions

end # User
