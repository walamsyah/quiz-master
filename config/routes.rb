Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'

  namespace :dashboard  do
    resources :categories, except: :show
    resources :questions, except: :show
    resources :users, except: [:show, :new, :create]
  end

  get 'dashboard', to: 'dashboard#index'

  resources :quizzes, only: :show do
    resources :questions, only: :create do
      post :start, on: :collection
    end
  end

  devise_for :users, controllers: { sessions: 'users/sessions' }

  root to: 'home#index'
end
