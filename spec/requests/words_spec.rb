require 'spec_helper'

describe "Words" do
  describe "new word" do
    describe "failure" do
      it "should not make a new word" do
        lambda do
          visit new_word_path
          fill_in "Word", :with => ""
          click_button
          response.should render_template('words/new')
          response.should have_selector("div#error_explanation")
        end.should_not change(Word, :count)
      end
    end
    describe "success" do
      it "should make a new word" do
        lambda do
          visit new_word_path
          fill_in "Word", :with => "brevity"
          click_button
          response.should have_selector("div.flash.success",
                                        :content => "added")
          response.should render_template('words/show')
        end.should change(Word, :count).by(1)
      end
    end
  end
end
