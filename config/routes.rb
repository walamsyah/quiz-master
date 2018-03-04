Rails.application.routes.draw do
  namespace :dashboard  do
    resources :categories, except: :show
    resources :questions, except: :show
  end

  get 'dashboard', to: 'dashboard#index'
end
