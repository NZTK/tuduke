Rails.application.routes.draw do

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users, only: [:index, :edit, :show, :update, :destroy], shallow: true do
  	member do
  		get 'like'
  		get 'history'
  		get 'follow'
      get 'novels'
      get 'novel_contents'
  	end
  end
  resources :novels do
  	collection do
  		get 'ranking'
  	end
  	resources :novel_contents, only: [:show, :new, :edit, :update, :destroy, :create]  do
  		resources :comments, only: [:create, :destroy]
  		resource :likes, only: [:create, :destroy]
  		resource :history, only: [:create, :destroy]
  	end
  end
  root 'novels#index'
  get 'about/index'
  resources :genres, only: [:new, :create, :destroy]
  get 'tags/:tag', to: 'novels#index', as: :tag
  resources :relationships, only: [:create, :destroy]

end
