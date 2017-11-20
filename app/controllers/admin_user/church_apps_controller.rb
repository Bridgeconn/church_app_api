class AdminUser::ChurchAppsController < ApplicationController
  before_action :set_church_app, only: [:show, :edit, :update, :destroy]
  before_action :redirect_unless_admin, except: [:index, :show]

  def index
    @church_apps = ChurchApp.all
  end

  def show
  end

  def new
    @church_app = ChurchApp.new
  end

  def edit
  end

  def create
    @church_app = current_user.build_church_app(church_app_params)
    @church_app.church_app_id = church_id_generate
    respond_to do |format|
      if @church_app.save
        format.html { redirect_to @church_app, notice: 'Church app was successfully created.' }
        format.json { render :show, status: :created, location: @church_app }
      else
        format.html { render :new }
        format.json { render json: @church_app.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    respond_to do |format|
      if @church_app.update(church_app_params)
        format.html { redirect_to @church_app, notice: 'Church app was successfully updated.' }
        format.json { render :show, status: :ok, location: @church_app }
      else
        format.html { render :edit }
        format.json { render json: @church_app.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @church_app.destroy
    respond_to do |format|
      format.html { redirect_to admin_user_user_church_apps_path, notice: 'Church app was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_church_app
      @church_app = ChurchApp.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def church_app_params
      params.fetch(:church_app).permit(:name, :church_app_id)
    end
end
 