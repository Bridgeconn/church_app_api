class Api::V1::EventsController < ApplicationController
  skip_before_action :verify_authenticity_token
  respond_to :json
  

  def index
    resource = User.find_by_auth_token(request.headers["AUTH-TOKEN"])
    if resource
      if request.headers["Church-App-Id"].present?
        @churchId = request.headers["Church-App-Id"]
        @churchApp = ChurchApp.find_by_church_app_id("#{@churchId}")
        @church_admin = User.find(resource.member_belongs_to_admin) rescue nil
        
        if @church_admin.church_app.present?
          @events = @churchApp.events
          event_json = @events.map do |event| 
                    {name: event.event_name, event_venue_name: event.event_venue_name, 
                      start_date: event.event_start_time.strftime("%B %e, %Y at %I:%M %p"), end_date: event.event_end_time.strftime("%B %e, %Y at %I:%M %p"), 
                      speaker_name: event.event_speaker, event_banner: "#{request.protocol}#{request.host_with_port}#{event.event_avtars_url}"}
          end
          render :json=> {:success=>true, :events=> event_json}, :status=>200
        else
          @events = nil
          render :json=> {:success=>false, :events=> @events}, :status=>204
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
