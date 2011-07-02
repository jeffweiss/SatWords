require 'spec_helper'

describe WordsController do
  render_views

  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end

    it "should have the right title" do
      get 'new'
      response.should have_selector("title", :content => "New Word")
    end
  end

  describe "POST 'create'" do

    describe "failure" do

      before(:each) do
        @attr = { :word => "" }
      end

      it "should not create a word" do
        lambda do
          post :create, :word => @attr
        end.should_not change(Word, :count)
      end

      it "should have the right title" do
        post :create, :word => @attr
        response.should have_selector("title", :content => "New Word")
      end

      it "should render the 'new' page" do
        post :create, :word => @attr
        response.should render_template('new')
      end
    end

    describe "success" do
      before(:each) do
        @attr = { :word => "Sample" }
      end

      it "should create a word" do
        lambda do
          post :create, :word => @attr
        end.should change(Word, :count).by(1)
      end

      it "should redirect to the word show page" do
        post :create, :word => @attr
        response.should redirect_to(word_path(assigns(:word)))
      end

      it "should have a flash message" do
        post :create, :word => @attr
        flash[:success].should =~ /added to word list/i
      end
    end
  end
end
