class AdminUser::UsersController < ApplicationController
	# before_action :set_user, only: [:show, :edit, :update, :destroy]
	# before_action :update_user_params, only: [:update]
	# before_action :redirect_unless_admin, except: [:index, :show]

	def index
		if (current_user.has_role? :super_admin)
			@users = User.with_role :admin
		else
			@users = User.with_role :member
		end
	end

	def show
	end

	def new
		@user = User.new
		@church_app = @user.build_church_app
	end

	def edit
	end

	def create
		@user = User.new(user_params)
		respond_to do |format|
			if @user.save
				if current_user.has_role? :super_admin
					@user.add_role :admin
				end
				format.html { redirect_to admin_user_users_path, notice: 'Admin  and their Church was successfully created.' }
				format.json { render :show, status: :created, location: @user }
			else
				format.html { render :new }
				format.json { render json: @user.errors, status: :unprocessable_entity }
			end
		end
	end

	def update
		respond_to do |format|
			if @user.update(user_params)
				format.html { redirect_to @user, notice: 'admin was successfully updated.' }
				format.json { render :show, status: :ok, location: @user }
			else
				format.html { render :edit }
				format.json { render json: @user.errors, status: :unprocessable_entity }
			end
		end
	end

	def destroy
		@user = User.find(params[:id])
		@user.destroy
		respond_to do |format|
			format.html { redirect_to admin_user_users_path, notice: 'User was successfully destroyed.' }
			format.json { head :no_content }
		end
	end

	private
	# Use callbacks to share common setup or constraints between actions.
	def set_user
		@user = User.find(params[:id])
	end

	# Never trust parameters from the scary internet, only allow the white list through.
	def user_params
		params.require(:user).permit(:email,:first_name,:last_name,:password,:password_confirmation, church_app_attributes: [:name, :church_app_id, :address1, :address3, :_destroy])
	end
	# Never trust parameters from the scary internet, only allow the white list through.
	def update_user_params
		params.require(:user).permit(:email,:first_name,:last_name)
	end
end
