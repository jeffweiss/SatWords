class ExamplesController < ApplicationController
  before_filter :authenticate

  def create
    @word = Word.find_by_id(params[:word_id])
    @definition = Definition.new if signed_in?
    @examples = @word.examples.clone
    @example = @word.examples.build(params[:example])
    if @example.save
      flash[:success] = "Example created!"
      redirect_to word_path(@word)
    else
      @definitions = @word.definitions
      render 'words/show'
    end
  end

  def destroy
  end
end
