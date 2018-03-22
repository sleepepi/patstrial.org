# frozen_string_literal: true

# Allows editors to create and update categories that organize document uploads.
class Editor::CategoriesController < Editor::EditorController
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  layout "layouts/full_page_sidebar"

  # GET /categories
  def index
    @order = scrub_order(Category, params[:order], "categories.position")
    @categories = Category.current.order(@order).page(params[:page]).per(40)
  end

  # # GET /categories/1
  # def show
  # end

  # GET /categories/new
  def new
    @category = Category.new(position: Category.current.count + 1)
  end

  # # GET /categories/1/edit
  # def edit
  # end

  # POST /categories
  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to editor_category_path(@category), notice: "Category was successfully created."
    else
      render :new
    end
  end

  # PATCH /categories/1
  def update
    if @category.update(category_params)
      redirect_to editor_category_path(@category), notice: "Category was successfully updated."
    else
      render :edit
    end
  end

  # DELETE /categories/1
  def destroy
    @category.destroy
    redirect_to editor_categories_path, notice: "Category was successfully deleted."
  end

  private

  def set_category
    @category = Category.current.find_by_param(params[:id])
    empty_response_or_root_path(editor_categories_path) unless @category
  end

  def category_params
    params.require(:category).permit(
      :name, :description, :top_level, :slug, :position, :archived,
      :unblinded_only
    )
  end
end
