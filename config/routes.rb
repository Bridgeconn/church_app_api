Rails.application.routes.draw do

	namespace :api do
		namespace :v1 do
			devise_for :users,  path_names: {sign_in: "login", sign_out: "logout"},
				controllers: {registrations: "api/v1/registrations", sessions: "api/v1/sessions"}

			resources :events, only: [:index]
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

	namespace :admin_user do
		resources :users
	end

	namespace :admin_user do
		resources :users, only: [] do
			resources :church_apps
		end
	end

	post "admin_user/users/:user_id/member_approval/:member_id" => "admin_user/users#approve_member", as: :member_approval
	
	resources :church_apps, only: [] do
		resources :events
	end

end
