class Dashboard::UsersController < DashboardController
  before_action :get_user, only: [:edit, :update, :destroy]

  def index
    if params[:role].present?
      @users = User.where(role: params[:role])
    else
      @users = User.order(updated_at: :desc)
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to dashboard_users_path, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to dashboard_users_path, notice: 'User was successfully deleted.'
  end

  private
  
  def get_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:role)
  end
end
