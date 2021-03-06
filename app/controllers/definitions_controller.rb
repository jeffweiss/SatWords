class DefinitionsController < ApplicationController
  before_filter :authenticate

  def create
    @word = Word.find_by_id(params[:word_id])
    @example = Example.new if signed_in?
    @definitions = @word.definitions.clone
    @definition = @word.definitions.build(params[:definition])
    if @definition.save
      flash[:success] = "Definition created!"
      redirect_to word_path(@word)
    else
      @examples = @word.examples
      render 'words/show'
    end
  end

  def destroy
  end
end
