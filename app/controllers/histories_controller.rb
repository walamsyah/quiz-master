class HistoriesController < ApplicationController
  before_action :authenticate_user!

  def index
    @histories = current_user.category_playings.order(id: :desc).page(params[:page]).per(10)
  end
end
