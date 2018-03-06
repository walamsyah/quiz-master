class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  rescue_from ActiveRecord::RecordNotFound do
    respond_to do |format|
      format.html do
        redirect_to '/404.html'
      end

      format.any do
        render body: nil, status: 404
      end
    end
  end
end
