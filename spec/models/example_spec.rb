require 'spec_helper'

describe Example do

  before(:each) do
    @word = Factory(:word)
    @attr = { :content => "value for content" }
  end

  it "should create a new instance given valid attributes" do
    @word.examples.create!(@attr)
  end

  describe "word associations" do
    before(:each) do
      @example = @word.examples.create(@attr)
    end

    it "should have a word attribute" do
      @example.should respond_to(:word)
    end

    it "should have the right associated word" do
      @example.word_id.should == @word.id
      @example.word.should == @word
    end
  end

  describe "validations" do
    it "should require a user id" do
      Example.new(@attr).should_not be_valid
    end

    it "should require nonblank content" do
      @word.examples.build(:content => "  ").should_not be_valid
    end

    it "should reject long content" do
      @word.examples.build(:content => "a" * 256).should_not be_valid
    end
  end
end
