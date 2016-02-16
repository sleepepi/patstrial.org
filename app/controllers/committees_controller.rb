# frozen_string_literal: true

# Allows viewers, editors, and admins to view committees and committee members
class CommitteesController < ApplicationController
  before_action :authenticate_viewer_or_current_user!
  before_action :set_committee, only: :show

  def show
  end

  def index
    @order = scrub_order(Member, params[:order], 'members.last_name')
  end

  private

  def set_committee
    @committee = Committee.current.find_by_slug params[:committee]
    empty_response_or_root_path(committees_path) unless @committee
  end
end
