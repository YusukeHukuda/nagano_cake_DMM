Rails.application.routes.draw do

  devise_for :customers, controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
  }

  root to: 'public/homes#top'
  get 'about', to: 'public/homes#about'


  get '/customers' => "public/customers#show"
  get '/customers/information/edit' => "public/customers#edit"

  patch '/customers/information' => "public/customers#update"
  get '/customers/unsubscribe' => 'public/customers#unsubscribe'
  patch '/customers/withdraw' => 'public/customers#withdraw'

  scope module: :public do
  resources :addresses, only: [:index, :create, :edit, :update, :destroy]
  resources :items, only: [:index, :show]
  delete '/cart_items/destroy_all' => 'cart_items#destroy_all'
  resources :cart_items, only: [:index, :update, :destroy, :create]

  post '/orders/confirmation' => 'orders#confirmation', as: 'confirmation'
  get '/orders/thanks' => 'orders#thanks', as: 'thanks'
  post '/orders/thanks' => 'orders#create'
  resources :orders, only: [:new, :index, :show]

  end
  # get 'genres/index'
  # get 'genres/edit'

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
