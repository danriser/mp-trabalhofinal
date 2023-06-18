require 'rails_helper'

RSpec.describe Preference, type: :model do
  context "testing factory" do
    it{expect(build(:preference,tipo:"teste",descricao:"teste")).to be_valid}
  end

  context "validating tipo presence" do
    it "should be invalid if presence=nil" do
      expect(build(:preference,tipo:nil,descricao:"hi")).to be_invalid
    end
  end

  context "validating tipo uniqueness" do
    it "should be invalid if tipo already taken" do
      create(:preference,tipo:"teste",descricao:"teste")
      expect(build(:preference,tipo:"teste",descricao:"teste")).to be_invalid
    end
  end

  context "validating descricao presence" do
    it "should be invalid if descricao=nil" do
      expect(build(:preference,tipo:"teste",descricao:nil)).to be_invalid
    end
  end

end
