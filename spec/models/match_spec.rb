require 'rails_helper'

RSpec.describe Match, type: :model do
  context "testing factory" do
    it do
      create(:user,id:1,nome:"joao",senha:"joao")
      create(:user,id:2,nome:"aa",senha:"aa")
      expect(build(:match,user_id:1,match_grade:0,user_id2:2)).to be_valid
    end
  end

  context "validating users presence" do
    it "should be invalid if user_id=nil or user_id2=nil" do
      expect(build(:match,user_id:nil,user_id2:nil)).to be_invalid  
    end
  end

  context "validating match_grade presence" do
    it "should be invalid if match_grade=nil" do
      create(:user,id:1,nome:"joao",senha:"joao")
      create(:user,id:2,nome:"aa",senha:"aa")
      expect(build(:match,user_id:1,match_grade:nil,user_id2:2)).to be_invalid
    end
  end
end