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
end
