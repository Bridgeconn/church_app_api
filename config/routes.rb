Rails.application.routes.draw do

	namespace :api do
		namespace :v1 do
			devise_for :users,  path_names: {sign_in: "login", sign_out: "logout"},
				controllers: {registrations: "api/v1/registrations", sessions: "api/v1/sessions"}
		end
	end

	devise_for :users,  path_names: {sign_in: "login", sign_out: "logout"},
		controllers: {registrations: "users/registrations", sessions: "users/sessions"}

	devise_scope :user do
		authenticated :user do
			root 'home#index', as: :authenticated_root
		end

		unauthenticated do
			root 'devise/sessions#new', as: :unauthenticated_root
		end
	end

	resources :users do
		resources :church_apps
	end

	# get '/html_test' => 'church_apps#html_test'

end
