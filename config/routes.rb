Rails.application.routes.draw do
  # get 'genres/index'
  # get 'genres/edit'
  devise_for :customers, controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
  }

  devise_for :admin, controllers: {
  sessions: "admin/sessions"
  }

  get 'admin', to: 'admin/home#top'

  namespace :admin do
    resources :genres, only: [:index, :create, :edit, :update]
    resources :items, only: [:index, :new, :show, :create, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
  end

  # root to: ""
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
