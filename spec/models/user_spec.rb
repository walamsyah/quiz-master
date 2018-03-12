require 'rails_helper'

RSpec.describe User, type: :model do
  it "has columns" do
    should have_db_column(:name).of_type(:string)
    should have_db_column(:email).of_type(:string)
    should have_db_column(:role).of_type(:integer)
    should have_db_column(:encrypted_password).of_type(:string)
  end

  it "has associations" do
    is_expected.to have_many :category_playings
    is_expected.to have_many :question_answers
  end
  
  describe "default role when create user" do
    it "will have user role as default" do
      user = create :user
      expect(user.role).to eq "member"
    end
  end
end
