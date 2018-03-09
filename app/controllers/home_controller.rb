class HomeController < ApplicationController
  def index
    @categories = Category.latest.published.limit(3)
    @populars = Category.popular.limit(3)
  end
end
