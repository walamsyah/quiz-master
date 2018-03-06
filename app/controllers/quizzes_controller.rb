class QuizzesController < ApplicationController
  def show
    @category = Category.published.find(params[:id])
  end
end
