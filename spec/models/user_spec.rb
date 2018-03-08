require 'rails_helper'

RSpec.describe User, type: :model do
  describe "default role when create user" do
    it "will have user role as default" do
      user = create :user
      expect(user.role).to eq "member"
    end
  end
end
