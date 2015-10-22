# Allows admins to create and update viewers who have read-only access to the
# site. Viewers are able to login using a username and password.
class Admin::ViewersController < Admin::AdminController
  before_action :set_viewer, only: [:show, :edit, :update, :destroy]

  # GET /viewers
  def index
    @order = scrub_order(Viewer, params[:order], 'viewers.username')
    @viewers = Viewer.order(@order).page(params[:page]).per(40)
  end

  # GET /viewers/1
  def show
  end

  # GET /viewers/new
  def new
    @viewer = Viewer.new
  end

  # GET /viewers/1/edit
  def edit
  end

  # POST /viewers
  def create
    @viewer = Viewer.new(viewer_params)
    if @viewer.save
      redirect_to @viewer, notice: 'Viewer was successfully created.'
    else
      render :new
    end
  end

  # PATCH /viewers/1
  def update
    if @viewer.update(viewer_params)
      redirect_to @viewer, notice: 'Viewer was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /viewers/1
  def destroy
    @viewer.destroy
    redirect_to viewers_path, notice: 'Viewer was successfully destroyed.'
  end

  private

  def set_viewer
    @viewer = Viewer.find_by_id params[:id]
    empty_response_or_root_path(viewers_path) unless @viewer
  end

  def viewer_params
    params[:viewer] = add_password_plain(params[:viewer] || {})
    params.require(:viewer).permit(:username, :password, :password_plain)
  end

  def add_password_plain(hash)
    hash[:password_plain] = hash[:password] unless hash[:password].blank?
    hash
  end
end