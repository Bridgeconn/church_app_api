class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # before_action :authenticate_user!
  
  respond_to :json, :html


  protected
  # Overwriting the sign_out redirect path method
  def after_sign_out_path_for(resource_or_scope)
    root_path
  end
  
  def after_sign_in_path_for(resource)
    authenticated_root_path
  end

  def redirect_unless_admin
    unless current_user.has_role? :admin
      flash[:error] = "Only admins can do that"
      redirect_to unauthenticated_root_path
    end
  end
end
