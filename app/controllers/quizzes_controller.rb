class QuizzesController < ApplicationController
  def index
    @categories = Category.latest.published.page(params[:page]).per(9)
  end

  def show
    @category = Category.published.find(params[:id])
  end
end
