class WordsController < ApplicationController
  def show
    @word = Word.find(params[:id])
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
end
