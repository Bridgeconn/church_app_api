Rails.application.routes.draw do
  root 'home#index'

 #  namespace :api do
 #  	namespace :v1 do
	#   	devise_for :users, controllers: { sessions: "sessions", registrations: "registrations" }
	#   end
	# end  

	namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      resources :users
      devise_for :users, path: '', path_names: {sign_in: "login", sign_out: "logout"},
                                      controllers: {registrations: "registrations", sessions: "sessions"}
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
