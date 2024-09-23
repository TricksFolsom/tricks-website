class DiscontinueNoticesController < ApplicationController
  before_action :set_discontinue_notice, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource :except => [:new, :create]
  # GET /discontinue_notices
  # GET /discontinue_notices.json
  def index
    @discontinue_notices = DiscontinueNotice.order("discontinue_notices.created_at DESC").limit(100)
  end

  # GET /discontinue_notices/1
  # GET /discontinue_notices/1.json
  def show
  end

  # GET /discontinue_notices/new
  # GET /discontinue_notices/new.json
  def new
    @discontinue_notice = DiscontinueNotice.new
  end

  # GET /discontinue_notices/1/edit
  def edit
  end

  # POST /discontinue_notices
  # POST /discontinue_notices.json
  def create
    params_with_location = discontinue_notice_params.merge(location: 1)
    @discontinue_notice = DiscontinueNotice.new(params_with_location)

    respond_to do |format|
      if verify_recaptcha(model: @discontinue_notice, action: 'submit', minimum_score: 0.5) && @discontinue_notice.save
        DiscontinueMailer.gym_notification(@discontinue_notice).deliver_now
        format.html { redirect_to root_path, notice: 'Notice to Discontinue was successfully submitted. Sorry to see you go :(' }
        format.json { render json: @discontinue_notice, status: :created, location: @discontinue_notice }
      else
        format.html { render action: "new" }
        format.json { render json: @discontinue_notice.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /discontinue_notices/1
  # PUT /discontinue_notices/1.json
  def update
    respond_to do |format|
      params_with_location = discontinue_notice_params.merge(location: 1)
      if @discontinue_notice.update(params_with_location)
        format.html { redirect_to @discontinue_notice, notice: 'Discontinue notice was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @discontinue_notice.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /discontinue_notices/1
  # DELETE /discontinue_notices/1.json
  def destroy
    @discontinue_notice.destroy

    respond_to do |format|
      format.html { redirect_to discontinue_notices_url }
      format.json { head :no_content }
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_discontinue_notice
      @discontinue_notice = DiscontinueNotice.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def discontinue_notice_params
      params.require(:discontinue_notice).permit(:class_day, :class_time, :last_day, :location, :parent_name, :reason, :student_first_name, :student_last_name, :understood)
    end
end
