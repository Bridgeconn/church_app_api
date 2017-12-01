class Api::V1::EventsController < ApplicationController
  # before_action :set_event, only: [:show, :edit, :update, :destroy]
  respond_to :json
  # before_action :authenticate

  def index
    if request.headers["Church-App-Id"].present? && request.headers["AUTH-TOKEN"].present?
      resource = User.find_by_authentication_token(params[:auth_token]||request.headers["AUTH-TOKEN"])
      if resource
        @churchId = request.headers["Church-App-Id"]
        @churchApp = ChurchApp.find_by_church_app_id("#{@churchId}")
        
        if resource.curch_apps.size > 0
          @events = @churchApp.events
          render :json=> {:success=>true, :events=> @events}, :status=>208
        else
          @events = nil
          render :json=> {:success=>false, :events=> @events}, :status=>208
        end
      else
        render :json=> {:success=>false, :message=> "Not valid request"}, :status=>400
      end
    end
  end
  
  protected
  # def authenticate
  #   authenticate_or_request_with_http_token do |token, options|
  #     User.find_by(auth_token: token)
  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @church_app = current_user.church_app
      @event = @church_app.events.find(params[:id])
    end
end
