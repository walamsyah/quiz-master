Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'

  namespace :dashboard  do
    resources :categories, except: :show
    resources :questions, except: :show
    resources :users, except: [:show, :new, :create]
  end

  resources :quizzes, only: [:show, :index] do
    resources :questions, only: :create do
      post :start, on: :collection
    end
  end

  get 'dashboard', to: 'dashboard#index'
  get 'histories', to: 'histories#index'
  get 'popular', to: 'popular#index'
  get 'search', to: 'search#index'

  devise_for :users, controllers: { sessions: 'users/sessions' }

  root to: 'home#index'
end
