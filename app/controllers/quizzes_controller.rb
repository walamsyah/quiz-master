class QuizzesController < ApplicationController
  def index
    @categories = Category.latest.published
  end

  def show
    @category = Category.published.find(params[:id])
  end
end
