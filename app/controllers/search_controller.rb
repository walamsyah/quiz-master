class SearchController < ApplicationController
  def index
    @query = ''
    @categories = ''
    if valid_query?
      @query = sanitize_query(params[:q])
      @categories = Category.published.search(@query).page(params[:page]).per(9)
    end

    @populars = Category.popular.limit(1) unless @categories.present?
  end

  private

  def sanitize_query(query)
    query.to_s.strip.truncate(70, separator: ' ', omission: '')
  end

  def valid_query?
    params[:q].present? && params[:q].strip.length >= 3
  end
end
