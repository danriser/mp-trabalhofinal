require 'rails_helper'

RSpec.describe Chat, type: :model do
  context "testing factory" do
    it do
      expect(build(:chat)).to be_valid
    end
  end
end
