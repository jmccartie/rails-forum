require 'spec_helper'

describe Topic do
  before do
    @topic = build(:topic)
  end

  describe "validations" do
    it "is valid" do
      @topic.should be_valid
    end

    %w[forum_id user_id posts_count].each do |attr|
      it "errors if #{attr} is not a number" do
        @topic.send("#{attr}=", "someString")
        @topic.should have(1).error_on(attr.to_sym)
      end
    end

    it "errors if title is not present" do
      @topic.title = nil
      @topic.should have(1).error_on(:title)
    end
  end

end
