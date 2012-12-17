require 'spec_helper'

describe Forum do
  describe "validations" do
    before do
      @forum = build(:forum)
    end

    it "is valid" do
      @forum.should be_valid
    end

    it "errors if name is not present" do
      @forum.name = nil
      @forum.should have(1).error_on(:name)
    end

  end
end
