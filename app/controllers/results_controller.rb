class ResultsController < ApplicationController
  def show
    @results = QuestionAnswer.where(category_token: params[:id]).order(id: :asc)
  end
end
