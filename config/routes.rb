Rails.application.routes.draw do

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users, only: [:index, :edit, :show, :update, :destroy] do
  	member do
  		get 'like'
  		get 'history'
  		get 'follow'
  	end
  end
  resources :novels do
  	collection do
  		get 'ranking'
  	end
  	resources :novel_contents, only: [:show, :new, :edit, :update, :destroy] do
  		resource :comments, only: [:create, :destroy]
  		resource :likes, only: [:create, :destroy]
  		resource :history, only: [:create, :destroy]
  	end
  end
  resources :relationships, only: [:create, :destroy]
  root 'novels#index'
  get 'about/index'
  resources :genres, only: [:new, :create, :destroy]
  get 'tags/:tag', to: 'novels#index', as: :tag

end
