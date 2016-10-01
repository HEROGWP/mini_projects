Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
	resources :videos
	root :to => "videos#index"
	get '*random' => 'videos#pass_url'
end
