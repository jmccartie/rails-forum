require 'spec_helper'

describe Post do
  before do
    @post = build(:post)
  end

  describe "validations" do
    it "is valid" do
      @post.should be_valid
    end

    %w[topic_id user_id content].each do |attr|
      it "errors if #{attr} is not present" do
        @post.send("#{attr}=", "")
        @post.should have(1).error_on(attr.to_sym)
        @post.send("#{attr}=", nil)
        @post.should have(1).error_on(attr.to_sym)
      end
    end

  end
end
