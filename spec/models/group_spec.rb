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

  context "validating group name" do
    it "should be invalid if group_name=nil" do
      expect(build(:group,group_name:nil,type:"A")).to be_invalid
    end
  end

end
