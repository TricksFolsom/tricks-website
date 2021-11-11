class TricksUVideosController < ApplicationController
  before_action :set_video, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  def index
    @videos = TricksUVideo.all
    @categories = TricksUCategory.where(hidden: false).order(:weight)
    @category = TricksUCategory.where(title: params[:category]).first
    if (@category.nil?) then
      @videos_by_category = @videos
    else
      @videos_by_category = TricksUVideo.where(category_id: @category.id).order(:weight)
    end
  end

  def show
  end

  def new
    @video = TricksUVideo.new
  end

  def edit
  end

  def create
    @video = TricksUVideo.new(tricks_u_video_params)

    # now we need to take the given URL and rip out the video ID, then we can use it to create an embeded link.
    url = tricks_u_video_params[:url].delete_prefix('"').delete_suffix('"')
    if url.include? "youtu"
      if (url.include? "embed") || (url.include? "youtu.be")
        # an "embed" link was given, video id is at the end of the path
        video_id = url.split('/').last
      else
        uri = Addressable::URI.parse(url)
        video_id = uri.query_values["v"]
      end
      
      if !video_id.nil?
        @video.url = "https://www.youtube.com/embed/" + video_id
      end
    end

    respond_to do |format|
      if @video.save
        format.html { redirect_to tricksu_path }
        format.json { render json: @video, status: :created, location: @video }
      else
        format.html { render action: "new" }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    # now we need to take the given URL and rip out the video ID, then we can use it to create an embeded link.
    new_params = tricks_u_video_params
    url = new_params[:url].delete_prefix('"').delete_suffix('"')
    if url.include? "youtu"
      if (url.include? "embed") || (url.include? "youtu.be")
        # an "embed" link was given, video id is at the end of the path
        video_id = url.split('/').last
      else
        uri = Addressable::URI.parse(url)
        if !uri.query_values.nil?
          video_id = uri.query_values["v"]
        end
      end

      if !video_id.nil?
        new_params[:url] = "https://www.youtube.com/embed/" + video_id
      end
    end

    respond_to do |format|
      if @video.update(new_params)
        format.html { redirect_to @video, notice: 'Video was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @video.destroy

    respond_to do |format|
      format.html { redirect_to tricks_u_videos_url }
      format.json { head :no_content }
    end
  end
  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_video
      @video = TricksUVideo.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def tricks_u_video_params
      params.require(:tricks_u_video).permit(:title, :url, :weight, :category_id)
      # params.require(:tricks_u_video).permit!
    end
end
