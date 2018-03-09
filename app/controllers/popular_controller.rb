class PopularController < ApplicationController
  def index
    @categories = Category.popular.page(params[:page]).per(9)
  end
end
