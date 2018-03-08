class DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_role

  layout "dashboard"

  def index
  end

  private

  def authenticate_role
    if current_user.role != 'admin'
      return redirect_to root_path, alert: 'You not have authorization'
    end
  end
end
