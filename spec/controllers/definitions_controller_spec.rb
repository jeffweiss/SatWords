require 'spec_helper'

describe DefinitionsController do
  render_views
  
  before(:each) do
    @word = Factory(:word)
  end

  describe "access control" do
    it "should deny access to 'create'" do
      post :create, :word_id => @word.id
      response.should redirect_to(signin_path)
    end

    it "should deny access to 'destroy'" do
      delete :destroy, :id => 1, :word_id => @word.id
      response.should redirect_to(signin_path)
    end
  end

  describe "POST 'create'" do
    before(:each) do
      @user = test_sign_in(Factory(:user))
    end

    describe "failure" do
      before(:each) do
        @attr = { :content => "" }
      end

      it "should not create a definition" do
        lambda do
          post :create, :definition => @attr, :word_id => @word.id
        end.should_not change(Definition, :count)
      end

      it "should render the word show page" do
        post :create, :definition => @attr, :word_id => @word.id
        response.should render_template('words/show')
      end
    end

    describe "success" do
      before(:each) do
        @attr = { :content => "Lorem ipsum" }
      end

      it "should create a definition" do
        lambda do
          post :create, :definition => @attr, :word_id => @word.id
        end.should change(Definition, :count).by(1)
      end

      it "should redirect to the word page" do
        post :create, :definition => @attr, :word_id => @word.id
        response.should redirect_to(word_path(@word))
      end

      it "should have a flash message" do
        post :create, :definition => @attr, :word_id => @word.id
        flash[:success].should =~ /definition created/i
      end
    end
  end
end
