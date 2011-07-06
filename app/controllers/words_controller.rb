class WordsController < ApplicationController
  before_filter :authenticate, :only => [:new, :show, :edit, :update, :destroy]
  before_filter :admin_user,   :only => :destroy

  def index
    @title = "All words"
    @words = Word.paginate(:page => params[:page])
  end

  def show
    @word = Word.find(params[:id])
    @definitions = @word.definitions
    @definition = Definition.new if signed_in?
    @example = Example.new if signed_in?
    @examples = @word.examples
    @title = @word.word
  end

  def new
    @word = Word.new
    @title = "New Word"
  end

  def create
    @word = Word.new(params[:word])
    if @word.save
      flash[:success] = "#{@word.word} added to word list"
      redirect_to @word
    else
      @title = "New Word"
      render 'new'
    end
  end
  
  def edit
    @word = Word.find(params[:id])
    @title = "Edit word"
  end

  def update
    @word = Word.find(params[:id])
    if @word.update_attributes(params[:word])
      flash[:success] = "Word updated."
      redirect_to @word
    else
      @title = "Edit word"
      render 'edit'
    end
  end

  def destroy
    Word.find(params[:id]).destroy
    flash[:success] = "Word deleted."
    redirect_to words_path
  end

  private

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end
