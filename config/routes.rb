Rails.application.routes.draw do
	root 'home#index'

	resources :users

	namespace :api, defaults: {format: 'json'} do
		namespace :v1 do
			devise_for :users,  path_names: {sign_in: "login", sign_out: "logout"},
				controllers: {registrations: "api/v1/registrations", sessions: "api/v1/sessions"}
		end
	end

	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
