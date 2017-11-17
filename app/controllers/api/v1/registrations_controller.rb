class Api::V1::RegistrationsController < Devise::RegistrationsController
	skip_before_action :verify_authenticity_token
	respond_to :json

	def create
		if request.headers["Church-App-Id"].present?
			@churchId = request.headers["Church-App-Id"]
			@churchApp = ChurchApp.find_by_church_app_id("#{@churchId}")
			if @churchApp.present?
				@admin_user = @churchApp.user
				user = User.new(user_params)
				user.add_role :member
				user.member_belongs_to_admin = @admin_user.id
				if user.save
					render :json=> {:auth_token=>user.auth_token, :email=>user.email, :church=>@churchApp, :admin=>@admin_user, :status=>201}
					return
				else
					warden.custom_failure!
					render :json=> user.errors, :status=>422
				end
			else
				render :json=> {:invalid=>"Church App Invalid.", :suggestion=>"Contact to Church Owner."}, :status=>208
			end
		end
	end


	def user_params
		params.require(:user).permit(:email, :password, :confirm_password)
	end

end
