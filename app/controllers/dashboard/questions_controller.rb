class Dashboard::QuestionsController < DashboardController
  before_action :get_question, only: [:edit, :update, :destroy]

  def index
    @questions = Question.order(id: :desc)
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)

    if @question.save
      redirect_to dashboard_questions_path, notice: 'Quiz question was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @question.update(question_params)
      redirect_to dashboard_questions_path, notice: 'Quiz question was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @question.destroy
    redirect_to dashboard_questions_path, notice: 'Quiz question was successfully deleted.'
  end

  private
  
  def get_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:category_id, :content, :answer, :published, :position)
  end
end
