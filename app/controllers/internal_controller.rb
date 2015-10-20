class InternalController < ApplicationController
  before_action :authenticate_user!

  def dashboard
  end

  def directory
    @order = scrub_order(Member, params[:order], 'members.last_name')
    @members = Member.current.order(@order).page(params[:page]).per(40)
  end
end
