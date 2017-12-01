class Api::V1::EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  respond_to :json
  before_action :authenticate

  def index
    if request.headers["Church-App-Id"].present?
      @churchId = request.headers["Church-App-Id"]
      @churchApp = ChurchApp.find_by_church_app_id("#{@churchId}")
      resource = User.find_for_database_authentication(:email=>params[:email])
      if current_user.present?  && (current_user.curch_apps.size > 0)
        @events = Event.all
        render :json=> {:success=>true, :events=>@events}, :status=>208
      else
        @events = nil
        render :json=> {:success=>false, :events=nil}, :status=>208
      end
  end
  
  protected
  def authenticate
    authenticate_or_request_with_http_token do |token, options|
      User.find_by(auth_token: token)
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @church_app = current_user.church_app
      @event = @church_app.events.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.fetch(:event).permit(:event_name, :church_app_id, :event_venue_name, :event_start_time, :event_end_time, :event_speaker, {event_avtars: []})
    end
end
