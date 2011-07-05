require 'spec_helper'

describe Word do

  before(:each) do
    @attr = { :word => "Example" }
  end

  it "should create a new instance given valid attributes" do
    Word.create!(@attr)
  end

  it "should require a word" do
    no_word_word = Word.new(@attr.merge(:word => ""))
    no_word_word.should_not be_valid
  end

  it "should reject words that are too long" do
    long_word = "a" * 51
    long_word_word = Word.new(@attr.merge(:word => long_word))
    long_word_word.should_not be_valid
  end
 
  it "should reject duplicate words" do
    Word.create!(@attr)
    duplicate_word = Word.new(@attr)
    duplicate_word.should_not be_valid
  end

  it "should reject words identical up to case" do
    upcased_word = @attr[:word].upcase
    Word.create!(@attr.merge(:word => upcased_word))
    word_with_duplicate_word = Word.new(@attr)
    word_with_duplicate_word.should_not be_valid
  end

  describe "definition associations" do

    before(:each) do
      @word = Word.create(@attr)
      @d1 = Factory(:definition, :word => @word, :created_at => 1.hour.ago)
      @d2 = Factory(:definition, :word => @word, :created_at => 1.day.ago)
    end

    it "should have a definitions attribute" do
      @word.should respond_to(:definitions)
    end

    it "should have the right definitions in the right order" do
      @word.definitions.should == [@d2, @d1]
    end

    it "should destroy associated definitions" do
      @word.destroy
      [@d1, @d2].each do |definition|
        Definition.find_by_id(definition.id).should be_nil
      end
    end
  end

  describe "example associations" do
    before(:each) do
      @word = Word.create(@attr)
      @e1 = Factory(:example, :word => @word, :created_at => 1.hour.ago)
      @e2 = Factory(:example, :word => @word, :created_at => 1.day.ago)
    end

    it "should have an examples attribute" do
      @word.should respond_to(:examples)
    end

    it "should have the right examples in the right order" do
      @word.examples.should == [@e2, @e1]
    end

    it "should destroy associated examples" do
      @word.destroy
      [@e1, @e2].each do |example|
        Example.find_by_id(example.id).should be_nil
      end
    end
  end

  it "should have the right words in the right order" do
    @w1 = Factory(:word, :word => "brevity")
    @w2 = Factory(:word, :word => "bicuspid")
    Word.create(@w1)
    Word.create(@w2)
    Word.all.should == [@w2, @w1]
  end
end
