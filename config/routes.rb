Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'

  namespace :dashboard  do
    resources :categories, except: :show
    resources :questions, except: :show
  end

  get 'dashboard', to: 'dashboard#index'

  root to: 'home#index'
end
