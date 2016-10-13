Rails.application.routes.draw do
  devise_for :users 

  resource :favorite, only: [:show, :create, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

	resource :profile, only: [:show, :create, :edit, :update]
	
	resources :videos
	resources :topics do
		resources :comments, only: [:new, :create, :edit, :update, :destroy]
		member do
			post :like
			post :unlike
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
