require 'rails_helper'

RSpec.describe User, type: :model do
  context "testing factory" do
    it {expect(build(:user)).to be_valid}
  end

  context "validanting username presence" do
    it "should be invalid if username==nil" do
      expect(build(:user,username:nil)).to be_invalid
    end
  end

  context "validating password presence" do
    it "should be invalid if password==nil" do
      expect(build(:user,password:nil)).to be_invalid
    end
  end

  context "validating username uniqueness" do
    it "should be invalid if username already taken" do
      create(:user,username:"david",password:"teste")
      expect(build(:user,username:"david",password:"teste")).to be_invalid
    end
  end

end
