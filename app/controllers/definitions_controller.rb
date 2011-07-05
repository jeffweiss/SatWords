class DefinitionsController < ApplicationController
  before_filter :authenticate

  def create
    @definition = current_word.definitions.build(params[:definition])
    if @definition.save
      flash[:success] = "Definition created!"
      redirect_to word_path, :word => current_word
    else
      render 'words/show', :word => current_word
    end
  end

  def destroy
  end
end
