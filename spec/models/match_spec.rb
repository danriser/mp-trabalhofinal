require 'rails_helper'

RSpec.describe Match, type: :model do

  context "testing factory" do
    it do
      create(:user,username:"a",password:"a")
      create(:user,username:"b",password:"b")
      expect(build(:match,id_usuarios:"a")).to be_valid
    end
  end
end
