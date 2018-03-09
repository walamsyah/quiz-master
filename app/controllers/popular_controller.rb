class PopularController < ApplicationController
  def index
    @categories = Category.popular
  end
end
