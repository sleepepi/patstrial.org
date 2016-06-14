# frozen_string_literal: true

# Displays core reports for the study.
class ReportsController < ApplicationController
  before_action :authenticate_viewer_or_current_user!
  before_action :load_recruitment

  def screened
    @screened = @recruitment[:screened] if @recruitment
  end

  def consented
    @consented = @recruitment[:consented] if @recruitment
  end

  def eligible
    @eligible = @recruitment[:eligible] if @recruitment
  end

  def randomized
    @randomized = @recruitment[:randomized] if @recruitment
  end

  private

  def load_recruitment
    @recruitment = read_json(Rails.root.join('carrierwave', 'recruitment.json'))
  end
end
