class QuestionsController < ApplicationController
  layout false

  before_action :get_category_and_questions, only: [:start, :create]

  def start
    @next_page = 2
  end

  def create
    save_question_answer

    if @questions.present?
      @next_page = @questions.current_page + 1
      render "start"
    else
      @results = QuestionAnswer.where(category_token: params[:category_token]).order(id: :asc)
      render "_result"
    end
  end

  private

  def get_category_and_questions
    @category   = Category.published.find(params[:quiz_id])
    @questions  = @category.questions.published.by_position.page(params[:page]).per(1)
  end

  def save_question_answer
    question = @category.questions.find(params[:question_id])

    question_answer = QuestionAnswer.new(question_answer_params)
    question_answer.category_id = params[:quiz_id]
    question_answer.is_correct  = question.check_correct_answer?(params[:answer]).to_s
    question_answer.save
  end

  def question_answer_params
    params.permit(:category_id, :question_id, :answer, :category_token)
  end
end
