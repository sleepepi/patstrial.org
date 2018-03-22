# frozen_string_literal: true

# Allows editors to associate members with committees
class Editor::CommitteeMembersController < Editor::EditorController
  before_action :set_committee
  before_action :set_committee_member, only: [:show, :edit, :update, :destroy]

  layout "layouts/full_page_sidebar"

  # GET /editor/committees/:committee_id/committee_members
  def index
    redirect_to editor_committee_path(@committee)
  end

  # GET /editor/committees/:committee_id/committee_members/1
  def show
    redirect_to editor_committee_path(@committee)
  end

  # GET /editor/committees/:committee_id/committee_members/new
  def new
    @committee_member = @committee.committee_members.new
  end

  # # GET /editor/committees/:committee_id/committee_members/1/edit
  # def edit
  # end

  # POST /editor/committees/:committee_id/committee_members
  def create
    @committee_member = @committee.committee_members.new(committee_member_params)
    if @committee_member.save
      redirect_to editor_committee_path(@committee), notice: "Committee member was successfully added."
    else
      render :new
    end
  end

  # PATCH /editor/committees/:committee_id/committee_members/1
  def update
    if @committee_member.update(committee_member_params)
      redirect_to editor_committee_path(@committee), notice: "Committee member was successfully updated."
    else
      render :edit
    end
  end

  # DELETE /editor/committees/:committee_id/committee_members/1
  def destroy
    @committee_member.destroy
    redirect_to editor_committee_path(@committee), notice: "Committee member was successfully removed."
  end

  private

  def set_committee
    @committee = Committee.current.find_by_param(params[:committee_id])
    empty_response_or_root_path(committees_path) unless @committee
  end

  def set_committee_member
    @committee_member = @committee.committee_members.find_by(id: params[:id])
    empty_response_or_root_path(editor_committee_path(@committee)) unless @committee_member
  end

  def committee_member_params
    params.require(:committee_member).permit(:member_id, :chair)
  end
end
