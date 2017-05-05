# frozen_string_literal: true

# Allows editors to embed videos on categories
class Editor::VideosController < Editor::EditorController
  before_action :set_category
  before_action :set_video, only: [:show, :edit, :update, :destroy]

  # GET /:category_id/videos
  def index
    @videos = @category.videos.page(params[:page]).per(40)
  end

  # # GET /:category_id/videos/1
  # def show
  # end

  # GET /:category_id/videos/new
  def new
    @video = @category.videos.new
  end

  # # GET /:category_id/videos/1/edit
  # def edit
  # end

  # POST /:category_id/videos
  def create
    @video = @category.videos.new(video_params)
    if @video.save
      redirect_to editor_category_video_path(@category, @video), notice: 'Video was successfully created.'
    else
      render :new
    end
  end

  # PATCH /:category_id/videos/1
  def update
    if @video.update(video_params)
      redirect_to editor_category_video_path(@category, @video), notice: 'Video was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /:category_id/videos/1
  def destroy
    @video.destroy
    redirect_to editor_category_videos_path(@category), notice: 'Video was successfully deleted.'
  end

  private

  def set_category
    @category = Category.current.find_by_param(params[:category_id])
    empty_response_or_root_path(editor_categories_path) unless @category
  end

  def set_video
    @video = @category.videos.find_by(id: params[:id])
    empty_response_or_root_path(editor_category_path(@category)) unless @video
  end

  def video_params
    params.require(:video).permit(:name, :embed_url, :archived)
  end
end
