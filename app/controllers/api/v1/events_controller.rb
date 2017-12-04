class Api::V1::EventsController < ApplicationController
  # before_action :set_event, only: [:show, :edit, :update, :destroy]
  respond_to :json
  # before_action :authenticate

  def index
    resource = User.find_by_auth_token(params[:auth_token]||request.headers["AUTH-TOKEN"])
    if resource
      if request.headers["Church-App-Id"].present?
        @churchId = request.headers["Church-App-Id"]
        @churchApp = ChurchApp.find_by_church_app_id("#{@churchId}")
        
        if resource.church_app
          @events = @churchApp.events
          render :json=> {:success=>true, :events=> @events}, :status=>208
        else
          @events = nil
          render :json=> {:success=>false, :events=> @events}, :status=>208
        end
      else
        render :json=> {:success=>false, :message=> "Church App Invalid, Please contact your church admin.!"}, :status=>400
      end
    else
      render :json=> {:success=>false, :message=> "You are not valid user.!"}, :status=>400
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @church_app = current_user.church_app
      @event = @church_app.events.find(params[:id])
    end
end
