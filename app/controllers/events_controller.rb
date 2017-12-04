class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]


  def index
    if current_user.present? && (current_user.has_role? :admin) #&& (current_user.curch_apps.size > 0)
      @events = Event.all
    else
      @events = nil
    end
  end

  def show
  
  end

  def new
    @church_app = current_user.church_app
    @event = @church_app.events.new
  end

  def edit
  end

  def create
    # raise event_params.inspect

    @event = current_user.church_app.events.new(event_params)
    respond_to do |format|
      if @event.save
        format.html { redirect_to church_app_events_path, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to church_app_events_path, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to church_appp_events_path, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content, deleted_from: "#{@church_app}", deleted: "#{@event}" }
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
      params.fetch(:event).permit(:event_name, :church_app_id, :event_venue_name, :event_start_time, :event_end_time, :event_speaker, :event_avtars)
    end
end
