require 'spec_helper'

describe WordsController do
  render_views

  describe "GET 'index'" do
    describe "for non-signed-in users" do
      it "should allow access" do
        get :index
        response.should be_success
      end
    end

    describe "for signed-in users" do
      before(:each) do
        @user = test_sign_in(Factory(:user))
        @word = Factory(:word)
        second = Factory(:word, :word => "bicuspid")
        third = Factory(:word, :word => "misanthrope")

        @words = [@word, second, third]
        @testable_words = [@word, second, third]
        30.times do
          fake_word = Faker::Lorem.words
          @words << Factory(:word, :word => fake_word)
        end
      end

      it "should be successful" do
        get :index
        response.should be_success
      end

      it "should have the right title" do
        get :index
        response.should have_selector("title", :content => "All words")
      end

      it "should have an element for each word" do
        get :index, :page => 2
        @testable_words.each do |word|
          response.should have_selector("li", :content => word.word)
        end
      end

      it "should paginate words" do
        get :index
        response.should have_selector("div.pagination")
        response.should have_selector("span.disabled", :content => "Previous")
        response.should have_selector("a", :href => "/words?page=2",
                                           :content => "2")
        response.should have_selector("a", :href => "/words?page=2",
                                           :content => "Next")
      end
    end
  end

  describe "GET 'show'" do
    before(:each) do
      @user = Factory(:user)
      test_sign_in(@user)
      @word = Factory(:word)
    end

    it "should show the word's definitions" do
      d1 = Factory(:definition, :word => @word, :content => "Foo bar definition")
      d2 = Factory(:definition, :word => @word, :content => "Baz quuz definition")

      get :show, :id => @word
      response.should have_selector("span.content", :content => d1.content)
      response.should have_selector("span.content", :content => d2.content)
    end

    it "should show the word's examples" do
      e1 = Factory(:example, :word => @word, :content => "Foo bar example")
      e2 = Factory(:example, :word => @word, :content => "Baz quuz example")

      get :show, :id => @word
      response.should have_selector("span.content", :content => e1.content)
      response.should have_selector("span.content", :content => e2.content)
    end
  end

  describe "GET 'new'" do
    before(:each) do
      @user = test_sign_in(Factory(:user))
    end

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
  describe "GET 'edit'" do
    before(:each) do
      @word = Factory(:word)
      @user = Factory(:user)
      test_sign_in(@user)
    end

    it "should be successful" do
      get :edit, :id => @word
      response.should be_success
    end

    it "should have the right title" do
      get :edit, :id => @word
      response.should have_selector("title", :content => "Edit word")
    end
  end

  describe "PUT 'update'" do
    before(:each) do
      @word = Factory(:word)
      @user = Factory(:user)
      test_sign_in(@user)
    end

    describe "failure" do
      before(:each) do
        @attr = { :word => "" }
      end

      it "should render the 'edit' page" do
        put :update, :id => @word, :word => @attr
        response.should render_template('edit')
      end

      it "should have the right title" do
        put :update, :id => @word, :word => @attr
        response.should have_selector("title", :content => "Edit word")
      end
    end

    describe "success" do
      before(:each) do
        @attr = { :word => "bicuspid" }
      end

      it "should change the word's attributes" do
        put :update, :id => @word, :word => @attr
        @word.reload
        @word.word.should == @word[:word]
      end

      it "should redirect to the word show page" do
        put :update, :id => @word, :word => @attr
        flash[:success].should =~ /updated/
      end
    end
  end

  describe "authentication of edit/update pages" do
    before (:each) do
      @word = Factory(:word)
    end

    describe "for non-signed-in users" do
      it "should deny access to 'edit'" do
        get :edit, :id => @word
        response.should redirect_to(signin_path)
      end

      it "should deny access to 'update'" do
        put :update, :id => @word, :word => {}
        response.should redirect_to(signin_path)
      end
    end
  end

  describe "DELETE 'destroy'" do
    before(:each) do
      @user = Factory(:user)
      @word = Factory(:word)
    end

    describe "as a non-signed-in user" do
      it "should deny access" do
        delete :destroy, :id => @word
        response.should redirect_to(signin_path)
      end
    end

    describe "as a non-admin user" do
      it "should protect the page" do
        test_sign_in(@user)
        delete :destroy, :id => @word
        response.should redirect_to(root_path)
      end
    end

    describe "as an admin user" do
      before(:each) do
        admin = Factory(:user, :email => "admin@example.com", :admin => true)
        test_sign_in(admin)
      end

      it "should destroy the word" do
        lambda do
          delete :destroy, :id => @word
        end.should change(Word, :count).by(-1)
      end

      it "should redirect to th words page" do
        delete :destroy, :id => @word
        response.should redirect_to(words_path)
      end
    end
  end
end
