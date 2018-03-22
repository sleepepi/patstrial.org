# frozen_string_literal: true

# Allows editors to create and update sites to group members in directory. Sites
# are also visible publicly on website
class Editor::SitesController < Editor::EditorController
  before_action :set_site, only: [:show, :edit, :update, :destroy]

  layout "layouts/full_page_sidebar"

  # GET /sites
  def index
    @order = scrub_order(Site, params[:order], "sites.name")
    @sites = Site.current.order(@order).page(params[:page]).per(40)
  end

  # # GET /sites/1
  # def show
  # end

  # GET /sites/new
  def new
    @site = Site.new
  end

  # # GET /sites/1/edit
  # def edit
  # end

  # POST /sites
  def create
    @site = Site.new(site_params)
    if @site.save
      redirect_to editor_site_path(@site), notice: "Site was successfully created."
    else
      render :new
    end
  end

  # PATCH /sites/1
  def update
    if @site.update(site_params)
      redirect_to editor_site_path(@site), notice: "Site was successfully updated."
    else
      render :edit
    end
  end

  # DELETE /sites/1
  def destroy
    @site.destroy
    redirect_to editor_sites_path, notice: "Site was successfully deleted."
  end

  private

  def set_site
    @site = Site.current.find_by_param(params[:id])
    empty_response_or_root_path(editor_sites_path) unless @site
  end

  def site_params
    params.require(:site).permit(:name, :slug, :address, :contact,
                                 :recruiting_center, :coordinating_center)
  end
end
