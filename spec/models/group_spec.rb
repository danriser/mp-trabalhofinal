require 'rails_helper'

RSpec.describe Group, type: :model do
  context "testing factory" do
    it{expect(build(:group,type:"a")).to be_valid}
  end

  context "validating group type" do
    it "should be invalid if group type=nil" do
      expect(build(:group,type:nil)).to be_invalid
    end
  end

  context "validating group name presence" do
    it "should be invalid if group_name=nil" do
      expect(build(:group,group_name:nil,type:"A")).to be_invalid
    end
  end

  context "validating group name uniqueness" do
    it "should be invalid if group_name already taken" do
      create(:group,group_name:"A",type:"A")
      expect(build(:group,group_name:"A",type:"A")).to be_invalid
    end
  end

  context "validating group description" do
    it "should be invalid if description=nil" do
      expect(build(:group,description:nil,group_name:"B",type:"B")).to be_invalid
    end
  end

  context "validating group preference" do
    it "should be invalid if group preference=nil" do
      expect(build(:group,group_name:"a",type:"a",description:"a",preference_id:nil)).to be_invalid
    end
  end

  context "validating group preference uniqueness" do
    it "should be invalid if group preference already taken" do
      create(:group,group_name:"a",type:"a",description:"a",preference_id:2)
      expect(build(:group,group_name:"b",type:"b",description:"b",preference_id:2)).to be_invalid
    end
  end

end
