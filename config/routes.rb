Rails.application.routes.draw do

  namespace :admin do
    get 'customers/index'
    get 'customers/show'
    get 'customers/edit'
  end
  namespace :admin do
    get 'items/index'
    get 'items/new'
    get 'items/show'
    get 'items/edit'
  end
  # get 'genres/index'
  # get 'genres/edit'
  devise_for :customers, controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
  }

  devise_for :admin, controllers: {
  sessions: "admin/sessions"
  }

  namespace :admin do
    resources :genres, only: [:index, :create, :edit, :update]
    resources :items, only: [:index, :new, :show, :create, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
  end

  # root to: ""
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
