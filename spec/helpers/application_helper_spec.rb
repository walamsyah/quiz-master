require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe "#true_or_false_icon" do
    it "will return icon_true if status is true" do
      icon = helper.true_or_false_icon(true)
      expect(icon).to eq '<i class="icon__true"></i>'
    end

    it "will return icon_false if status is false" do
      icon = helper.true_or_false_icon(false)
      expect(icon).to eq '<i class="icon__false"></i>'
    end
  end
end
