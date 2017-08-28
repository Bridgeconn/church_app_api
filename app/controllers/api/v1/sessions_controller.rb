class Api::V1::SessionsController < Devise::SessionsController
	prepend_before_action :verify_user, only: [:destroy]
	skip_before_action :verify_authenticity_token
	respond_to :json

	def create
		resource = User.find_for_database_authentication(:email=>params[:email])
		if resource.nil?
			render :json=> {:success=>false, :message=>"Error with your login or password"}, :status=>401
		end

		if resource.valid_password?(params[:password])
			sign_in("user", resource)
			render :json=> {:success=>true, :auth_token=>resource.auth_token,  :email=>resource.email}, :status=>201
		else
			render :json=> {:success=>false, :message=>"Error with your login or password"}, :status=>401
		end
	end

	def destroy
		sign_out(resource_name)
	end

	protected


	def invalid_login_attempt
		warden.custom_failure!
		render :json=> {:success=>false, :message=>"Error with your login or password"}, :status=>401
	end
end
