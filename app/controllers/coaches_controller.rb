class CoachesController < ApplicationController

  load_and_authorize_resource

  # GET /coaches
  # GET /coaches.json
  def index
    @levels = Level.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @coaches }
    end
  end

  # GET /coaches/1
  # GET /coaches/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @coach }
    end
  end

  # GET /coaches/new
  # GET /coaches/new.json
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @coach }
    end
  end

  # GET /coaches/1/edit
  def edit
  end

  # POST /coaches
  # POST /coaches.json
  def create
    respond_to do |format|
      if @coach.save
        format.html { redirect_to @coach, notice: 'Coach was successfully created.' }
        format.json { render json: @coach, status: :created, location: @coach }
      else
        format.html { render action: "new" }
        format.json { render json: @coach.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /coaches/1
  # PUT /coaches/1.json
  def update
    respond_to do |format|
      if @coach.update_attributes(params[:coach])
        format.html { redirect_to @coach, notice: 'Coach was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @coach.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /coaches/1
  # DELETE /coaches/1.json
  def destroy
    @coach.destroy

    respond_to do |format|
      format.html { redirect_to coaches_url }
      format.json { head :no_content }
    end
  end

  


end