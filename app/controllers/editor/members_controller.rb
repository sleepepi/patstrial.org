# frozen_string_literal: true

# Allows editors to create and update members in the directory
# Members are purely listings, and are not related to user logins
class Editor::MembersController < Editor::EditorController
  before_action :find_member_or_redirect, only: [:show, :edit, :update, :destroy]

  layout "layouts/full_page_sidebar"

  # GET /members
  def index
    scope = Member.current.search_any_order(params[:search])
    @members = scope_order(scope).page(params[:page]).per(40)
  end

  # # GET /members/1
  # def show
  # end

  # GET /members/new
  def new
    @member = Member.new
  end

  # # GET /members/1/edit
  # def edit
  # end

  # POST /members
  def create
    @member = Member.new(member_params)
    if @member.save
      redirect_to editor_member_path(@member), notice: "Member was successfully created."
    else
      render :new
    end
  end

  # PATCH /members/1
  def update
    if @member.update(member_params)
      redirect_to editor_member_path(@member), notice: "Member was successfully updated."
    else
      render :edit
    end
  end

  # DELETE /members/1
  def destroy
    @member.destroy
    redirect_to editor_members_path, notice: "Member was successfully deleted."
  end

  private

  def find_member_or_redirect
    @member = Member.current.find_by(id: params[:id])
    empty_response_or_root_path(editor_members_path) unless @member
  end

  def member_params
    params.require(:member).permit(
      :first_name, :last_name, :staffid, :email, :phone, :role, :site_id,
      :archived
    )
  end

  def scope_order(scope)
    @order = params[:order]
    scope.order(Arel.sql(Member::ORDERS[params[:order]] || Member::DEFAULT_ORDER))
  end
end
