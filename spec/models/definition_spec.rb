require 'spec_helper'

describe Definition do

  before(:each) do
    @word = Factory(:word)
    @attr = { :content => "value for content" }
  end

  it "should create a new instance given valid attributes" do
    @word.definitions.create!(@attr)
  end

  describe "word associations" do
    before(:each) do
      @definition = @word.definitions.create(@attr)
    end

    it "should have a word attribute" do
      @definition.should respond_to(:word)
    end

    it "should have the right associated word" do
      @definition.word_id.should == @word.id
      @definition.word.should == @word
    end
  end

  describe "validations" do
    it "should require a word id" do
      Definition.new(@attr).should_not be_valid
    end

    it "should require nonblank content" do
      @word.definitions.build(:content => "  ").should_not be_valid
    end

    it "should reject long content" do
      @word.definitions.build(:content => "a" * 101).should_not be_valid
    end
  end
end
