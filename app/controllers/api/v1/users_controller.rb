class Api::V1::UsersController < ApplicationController
	
	skip_before_action :verify_authenticity_token
	respond_to :json

	def contact_update
		resource = User.find_by_auth_token(request.headers["AUTH-TOKEN"])
		if resource && resource.approved?
      if request.headers["Church-App-Id"].present?
      	@churchId = request.headers["Church-App-Id"]
        @churchApp = ChurchApp.find_by_church_app_id("#{@churchId}")

        @church_admin = User.find(resource.member_belongs_to_admin) rescue nil
        if (@churchApp.user.id == @church_admin.id)
	        if @church_admin.church_app.present?
	        	resource.first_name = params[:first_name] rescue nil
	        	resource.last_name = params[:last_name] rescue nil
	        	resource.contact_number = params[:contact_number] rescue nil
	        	resource.contact_show_to_all = params[:contact_show] rescue nil

	        	if resource.save
	        		render :json=> {:success=>true, :first_name => resource.first_name , :last_name => resource.last_name, :contact_number => resource.contact_number, :contact_show_to_all => resource.contact_show_to_all, :message => "Contact details updated successfully!" }, :status=>200
	        	else
	        		render :json=> {:success=> false,  :message => "Something went wrong, Contact your church admin!" }, :status=>204
	        	end
	        else
	        	render :json=> {:success=> false,  :message => "You are not belongs to any church, Contact your church admin!" }, :status=>401
	        end
	      else
	      	render :json=> {:success=> false,  :message => "You are not belongs to this church, Contact your church admin!" }, :status=>401
	      end
      end
    else
    	render :json=> {:success=> false,  :message => "Your approval is pending from admin side, Contact your church admin!" }, :status=>400
    end
	end

	def get_user_contact
		resource = User.find_by_auth_token(request.headers["AUTH-TOKEN"])
		if resource && resource.approved?
      if request.headers["Church-App-Id"].present?
      	@churchId = request.headers["Church-App-Id"]
        @churchApp = ChurchApp.find_by_church_app_id("#{@churchId}")
        	
        @church_admin = User.find(resource.member_belongs_to_admin) rescue nil
        if (@churchApp.user.id == @church_admin.id)
	        if @church_admin.church_app.present?
	        	@contact_list = User.where(:member_belongs_to_admin => @churchApp.user.id, :approved => true, :contact_show_to_all => true)
	        	contact_json = @contact_list.map do |contact| 
                    {name: contact.full_name, contact_number: contact.contact_number, contact_info_public: contact.contact_show_to_all}
            end
            render :json=> {:success=>true, :contacts=> contact_json}, :status=>200
	        end
	      else
	      	render :json=> {:success=> false,  :message => "You are not belongs to this church, Contact your church admin!" }, :status=>400
	      end
	    else
	    	render :json=> {:success=> false,  :message => "You are not belongs to any church, Contact your church admin!" }, :status=>400
	    end
	  else
	  	render :json=> {:success=> false,  :message => "Your approval is pending from admin side, Contact your church admin!" }, :status=>400
	  end
	end

	private

	# Never trust parameters from the scary internet, only allow the white list through.
	def update_user_params
		params.require(:user).permit(:email,:first_name,:last_name)
	end
end
