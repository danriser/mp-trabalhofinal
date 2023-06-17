require 'rails_helper'

RSpec.describe Preference, type: :model do
  context "testing factory" do
    it {expect(build(:preference)).to be_valid}
  end

  context "validating preference_name presence" do
    it "should be invalid if preference_name=nil" do
      expect(build(:preference,preference_name:nil)).to be_invalid
    end
  end

  context "validating description presence" do
    it "should be invalid if description=nil" do
      expect(build(:preference,description:nil)).to be_invalid
    end
  end

  context "validating preference_name uniqueness" do
    it "should be invalid if preference_name already taken" do
      create(:preference,preference_name:"Filmes de comedia",description:"Filmes de Adam Sandler")
      expect(build(:preference,preference_name:"Filmes de comedia",description:"Filmes de Adam Sandler")).to be_invalid
    end
  end

end
