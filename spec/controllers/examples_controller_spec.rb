require 'spec_helper'

describe ExamplesController do
  render_views

  describe "access control" do
    it "should deny access to 'create'" do
      post :create
      response.should redirect_to(signin_path)
    end

    it "should deny access to 'destroy'" do
      delete :destroy, :id => 1
      response.should redirect_to(signin_path)
    end
  end
  
  describe "POST 'create'" do
    before(:each) do
      @user = test_sign_in(Factory(:user))
      @word = Factory(:word)
    end

    describe "failure" do
      before(:each) do
        @attr = { :content => "" }
      end

      it "should not create an example" do
        lambda do
          post :create, :example => @attr, :word => @word
        end.should_not change(Definition, :count)
      end

      it "should render the word show page" do
        post :create, :example => @attr, :word => @word
        response.should render_template('words/show')
      end
    end

    describe "success" do
      before(:each) do
        @attr = { :content => "Lorem ipsum" }
      end

      it "should create an example" do
        lambda do
          post :create, :example => @attr, :word => @word
        end.should change(Example, :count).by(1)
      end

      it "should redirect to the word page" do
        post :create, :example => @attr, :word => @word
        response.should redirect_to(word_path(@word))
      end

      it "should have a flash message" do
        post :create, :example => @attr, :word => @word
        flash[:success].should =~ /example created/i
      end
    end
  end
end
