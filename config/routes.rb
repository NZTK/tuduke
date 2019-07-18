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
      patch 'user_restore'
  	end
  end
  resources :novels do
  	collection do
  		get 'ranking'
      get 'novels_admin_index'
    end
    member do
      patch 'novel_restore'
  	end
  	resources :novel_contents, only: [:show, :new, :edit, :update, :destroy, :create]  do
  		resources :comments, only: [:create, :destroy]
  		resource :likes, only: [:create, :destroy]
  		resource :history, only: [:create, :destroy]
        member do
          patch 'novel_content_restore'
  	     end
    end
  end
  root 'novels#index'
  get 'about/index'
  get 'novel_contents/index'
  resources :genres, only: [:new, :create, :destroy]
  get 'tags/:tag', to: 'novels#index', as: :tag
  resources :relationships, only: [:create, :destroy]

end
