class Api::V1::SessionsController < Devise::SessionsController
	prepend_before_action :verify_user, only: [:destroy]
	skip_before_action :verify_authenticity_token
	respond_to :json

	def create
		if request.headers["Church-App-Id"].present?
			@churchId = request.headers["Church-App-Id"]
			@churchApp = ChurchApp.find_by_church_app_id("#{@churchId}")
			resource = User.find_for_database_authentication(:email=>params[:email])
			if resource.nil?
				render :json=> {:success=>false, :message=>"Error with your login or password"}, :status=>401
			end
			if resource.valid_password?(params[:password])	
				if resource.approved == true
					sign_in("user", resource)
					if resource.has_role? :member
						@admin_user = @churchApp.user
						render :json=> {:success=>true, :user => {:auth_token=>resource.auth_token,  :email=>resource.email, :first_name => resource.first_name, :last_name => resource.last_name, :user_status =>resource.approved, :user_contact =>resource.contact_number}, :admin_email=> @admin_user.email, :church_app_id => @churchApp.church_app_id, :church_name => @churchApp.name, :church_address => "#{@churchApp.address1 + " " + @churchApp.address3}", :status=>201}
					else
						render :json=> {:success=>false, :message=>"You are not valid user! Please Contact to Church Admin."}, :status=>208
					end
				else
					render :json=> {:success=>false, :message=>"Account is Not Approved Yet! Please Contact to Church Admin."}, :status=>208
				end
			else
				render :json=> {:success=>false, :message=>"Error with your login or password"}, :status=>401
			end
		else
			render :json=> {:invalid=>"Church App Invalid.", :suggestion=>"Contact to Church Owner."}, :status=>208
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
