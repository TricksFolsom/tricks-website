class AbsentsController < ApplicationController
  load_and_authorize_resource :except => [:new, :create]
  before_action :set_absent, only: [:show, :edit, :update, :destroy]
  # GET /absents
  # GET /absents.json
  def index
    @absents = Absent.joins(:level).joins(:classtype).order("created_at DESC").limit(100)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @absents }
    end
  end

  # GET /absents/new
  # GET /absents/new.json
  def new
    @absent = Absent.new
    @absent.reason = ""
  end

  # POST /absents
  # POST /absents.json
  def create
    @absent = Absent.new(absent_params)
    puts @absent
    respond_to do |format|
      if verify_recaptcha(model: @absent) && @absent.save
        AbsentMailer.gym_notification(@absent).deliver_now
        format.html { redirect_to thankyou_path, notice: 'Your absent notification has been submitted.' }
        format.json { render json: absents_path, status: :created, location: @absent }
      else
        format.html { render action: "new" }
        format.json { render json: @absent.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /absents/1
  # DELETE /absents/1.json
  def destroy
    @absent.destroy

    respond_to do |format|
      format.html { redirect_to absents_url }
      format.json { head :no_content }
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_absent
      @absent = Absent.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def absent_params
      params.require(:absent).permit(:first_name, :last_name, :location, :classtype_id, :level_id, :date, :time, :reason)
    end
end
