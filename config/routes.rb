Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" } 

  resources :friends, only: [:index, :destroy], :controller => "users" do 
  	member do
  		post :add
  		post :change_relationship
  	end

  	collection do
  		get :who_add_me
  	end
  end
  resource :favorite, only: [:show, :create, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

	resource :profile, only: [:create, :edit, :update] do
		collection do
			get :likes
		end
	end
	get 'profile/:user' => 'profiles#show'
	
	resources :videos
	resources :topics do
		resources :comments, only: [:new, :create, :edit, :update, :destroy]
		member do
			post :like
			post :unlike
			post :change_subscribe
		end
	end
	namespace :admin do
    resources :categories, only: [:index, :create, :update, :destroy]
    resources :users, only: [:create,:edit, :update] do
    	member do
      	get :role_change
    end
    end
  end
	root :to => "topics#index"
	get 'abouts' => 'abouts#index'

	get '*random' => 'videos#pass_url'
end
