require 'rails_helper'

RSpec.describe ListPreference, type: :model do
  context "testing factory" do
    it do
      create(:user,id:1,nome:"david",senha:"herbert")
      create(:preference,id:1,tipo:"teste",descricao:"teste")
      expect(build(:list_preference,user_id:1,preference_id:1)).to be_valid
    end
  end

  context "validating user presence" do
    it "should be invalid if user_id=nil" do
      create(:user,id:1,nome:"david",senha:"herbert")
      create(:preference,id:1,tipo:"teste",descricao:"teste")
      expect(build(:list_preference,user_id:nil,preference_id:1)).to be_invalid
    end
  end

  context "validating user existence" do
    it "should be invalid if user_id not registered" do
      create(:preference,id:1,tipo:"teste",descricao:"teste")
      expect(build(:list_preference,user_id:1,preference_id:1)).to be_invalid
    end
  end

  context "validating preference presence" do
    it "should be invalid if preference_id=nil" do
      create(:user,id:1,nome:"david",senha:"herbert")
      create(:preference,id:1,tipo:"teste",descricao:"teste")
      expect(build(:list_preference,user_id:1,preference_id:nil)).to be_invalid
    end
  end

  context "validating preference existence" do
    it "should be invalid if preference_id not registered" do
      create(:user,id:1,nome:"david",senha:"herbert")
      expect(build(:list_preference,user_id:1,preference_id:1)).to be_invalid
    end
  end

  context "validating user with multiple preferences" do
    it "should be valid if uses has 2 or more preferences" do
      create(:user,id:1,nome:"david",senha:"herbert")
      create(:preference,id:1,tipo:"teste",descricao:"teste")
      create(:preference,id:2,tipo:"filme",descricao:"filme")
      create(:list_preference,user_id:1,preference_id:1)
      expect(build(:list_preference,user_id:1,preference_id:2)).to be_valid
    end
  end

end
