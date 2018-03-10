class Dashboard::CategoriesController < DashboardController
  before_action :get_category, only: [:edit, :update, :destroy]

  def index
    @categories = Category.latest.page(params[:page]).per(10)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to dashboard_categories_path, notice: 'Quiz was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @category.update(category_params)
      redirect_to dashboard_categories_path, notice: 'Quiz was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @category.destroy
    redirect_to dashboard_categories_path, notice: 'Quiz was successfully deleted.'
  end

  private
  
  def get_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :description, :published, :image, :remove_image)
  end
end
