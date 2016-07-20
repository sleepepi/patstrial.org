# frozen_string_literal: true

# Allows admins to approve new users and specify user roles
class Admin::UsersController < Admin::AdminController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /admin/users
  def index
    @order = scrub_order(User, params[:order], 'users.current_sign_in_at DESC')
    @users = User.current.order(@order).page(params[:page]).per(40)
  end

  # GET /admin/users/1
  def show
  end

  # PATCH /admin/users/1
  def update
    original_approval = @user.approved
    if @user.update(user_params)
      UserMailer.status_approved(@user).deliver_now if EMAILS_ENABLED && original_approval.nil? && @user.approved?
      redirect_to admin_user_path(@user), notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /admin/users/1
  def destroy
    @user.destroy
    redirect_to admin_users_path
  end

  protected

  def set_user
    @user = User.current.find_by_id params[:id]
    empty_response_or_root_path(admin_users_path) unless @user
  end

  def user_params
    params.require(:user).permit(
      :first_name, :last_name, :email, :approved, :admin, :editor, :dsmb_member
    )
  end
end
