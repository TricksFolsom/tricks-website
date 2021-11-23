class KidsNightOutsController < ApplicationController
  load_and_authorize_resource :except => [:index]
  before_action :set_kids_night_out, only: [:edit, :update, :destroy]

  # GET /kids_night_outs
  def index
    @kids_night_outs = KidsNightOut.where("gb_datetime >= ?", Date.today)
                   .or(KidsNightOut.where("fol_datetime >= ?", Date.today))
                   .or(KidsNightOut.where("sac_datetime >= ?", Date.today))
                   .order(:created_at)
  end

  # GET /kids_night_outs/new
  def new
    @kids_night_out = KidsNightOut.new
  end

  # GET /kids_night_outs/1/edit
  def edit
  end

  # POST /kids_night_outs
  def create
    @kids_night_out = KidsNightOut.new(kids_night_out_params)

    if @kids_night_out.save
      redirect_to kids_night_outs_path, notice: 'Kids night out was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /kids_night_outs/1
  def update
    if @kids_night_out.update(kids_night_out_params)
      redirect_to kids_night_outs_path, notice: 'Kids night out was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /kids_night_outs/1
  def destroy
    @kids_night_out.destroy
    redirect_to kids_night_outs_url, notice: 'Kids night out was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_kids_night_out
      @kids_night_out = KidsNightOut.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def kids_night_out_params
      params.require(:kids_night_out).permit(:title, :details, :sac_datetime, :fol_datetime, :gb_datetime, :image, :image_new)
    end
end
