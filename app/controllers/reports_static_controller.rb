# frozen_string_literal: true

# Displays core reports for the study.
class ReportsStaticController < ApplicationController
  before_action :authenticate_user!
  before_action :load_recruitment

  layout "layouts/full_page_sidebar"

  def data_quality
    @data_quality = @recruitment.dig(:data_quality) if @recruitment
  end

  def demographics
    @subject_status = if %w(screened consented eligible randomized).include?(params[:subjects])
                        params[:subjects]
                      else
                        "randomized"
                      end
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
    redirect_to reports_static_eligibility_status_screened_path
  end

  def eligibility_status_screened
    @eligibility_status = @recruitment[:eligibility_status] if @recruitment
  end

  def eligibility_status_consented
    @eligibility_status = @recruitment[:eligibility_status_consented] if @recruitment
  end

  # GET /reports_static/grades
  def grades
    @grades = @recruitment.dig(:grades) if @recruitment
  end

  # GET /reports_static/unscheduled-events
  def unscheduled_events
    @unscheduled_events = @recruitment.dig(:unscheduled_events) if @recruitment
  end

  # GET /reports_static/data-inconsistencies
  def data_inconsistencies
    @data_inconsistencies = @recruitment.dig(:failing_checks) if @recruitment
  end

  private

  def load_recruitment
    @recruitment = read_json(Rails.root.join("carrierwave", "recruitment.json"))
  end
end
