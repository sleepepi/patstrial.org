# frozen_string_literal: true

# Displays core reports for the study.
class ReportsController < ApplicationController
  before_action :authenticate_viewer_or_current_user!
  before_action :load_recruitment

  def demographics
    @subject_status = (['screened', 'consented', 'eligible', 'randomized'].include?(params[:subjects]) ? params[:subjects] : 'screened')
    @demographics = @recruitment.dig(:demographics, @subject_status.to_sym) if @recruitment
    @demographics = @recruitment[:demographics] if @recruitment && @demographics.nil?
  end

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

  def eligibility_status
    @eligibility_status = @recruitment[:eligibility_status] if @recruitment
  end

  def eligibility_status_consented
    @eligibility_status = @recruitment[:eligibility_status_consented] if @recruitment
  end

  private

  def load_recruitment
    @recruitment = read_json(Rails.root.join('carrierwave', 'recruitment.json'))
  end
end
