# frozen_string_literal: true

# Displays user profile pictures.
class ProfilesController < ApplicationController
  before_action :find_user, only: [:picture]

  def picture
    profile_picture = (params[:thumb] == "1" ? @user&.profile_picture&.thumb : @user&.profile_picture)
    send_file_if_present profile_picture, disposition: "inline"
  end

  private

  def find_user
    @user = User.current.find_by("LOWER(username) = ?", params[:id].to_s.downcase)
  end
end
