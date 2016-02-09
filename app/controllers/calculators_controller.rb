# Publicly available calculators
class CalculatorsController < ApplicationController
  def index
  end

  def bmi_zscore
  end

  def bmi_zscore_calculate
    age_in_months = compute_age_in_months
    gender = compute_gender
    height = compute_height
    weight = compute_weight

    if age_in_months && age_in_months >= 24 && gender && height && height > 0 && weight && weight > 0
      bmi = Calculators::BmiZscore.compute_bmi(height, weight)
      params[:bmi] = bmi
      lms = Calculators::BmiZscore.lookup_lms(gender, age_in_months)
      zscore = Calculators::BmiZscore.compute_zscore(bmi, lms[:l], lms[:m], lms[:s])

      params[:l] = lms[:l]
      params[:m] = lms[:m]
      params[:s] = lms[:s]
      params[:zscore] = zscore
      params[:bmi_percentile] = Calculators::BmiZscore.compute_bmi_percentile(zscore)

      redirect_to calculators_bmi_zscore_result_path(zscore_params)
    elsif age_in_months && age_in_months < 24
      @error = 'The age of the child most be at least 24 months.'
      render :bmi_zscore
    else
      @error = 'Please enter all parameters.'
      render :bmi_zscore
    end
  end

  def bmi_zscore_result
  end

  def blood_pressure_percentile
  end

  def blood_pressure_percentile_calculate
    age_in_months = compute_age_in_months
    gender = compute_gender
    height = compute_height
    systolic = compute_systolic
    diastolic = compute_diastolic

    if age_in_months && age_in_months >= 24 && gender && height && height > 0 && systolic && systolic > 0 && diastolic && diastolic > 0
      lms = Calculators::BloodPressurePercentile.lookup_lms(gender, age_in_months)
      zscore = Calculators::BloodPressurePercentile.compute_zscore(height * 100, lms[:l], lms[:m], lms[:s])

      params[:l] = lms[:l]
      params[:m] = lms[:m]
      params[:s] = lms[:s]
      params[:zscore] = zscore
      params[:bpp] = 'Unknown' # bpp
      redirect_to calculators_blood_pressure_percentile_result_path(bpp_params)
    elsif age_in_months && age_in_months < 24
      @error = 'The age of the child most be at least 24 months.'
      render :blood_pressure_percentile
    else
      @error = 'Please enter all parameters.'
      render :blood_pressure_percentile
    end
  end

  def blood_pressure_percentile_result
  end

  private

  def zscore_params
    params.permit(:weight, :weight_units, :height, :height_units, :gender, :dob, :dov, :age_in_months, :l, :m, :s, :zscore, :bmi, :bmi_percentile)
  end

  def bpp_params
    params.permit(:height, :height_units, :systolic, :diastolic, :gender, :dob, :dov, :age_in_months, :l, :m, :s, :zscore, :bpp)
  end

  def parse_date(date_string, default_date: nil)
    if date_string.to_s.split('/').last.size == 2
      Date.strptime(date_string, '%m/%d/%y')
    else
      Date.strptime(date_string, '%m/%d/%Y')
    end
  rescue
    default_date
  end

  def compute_age_in_months
    dob = parse_date(params[:dob])
    dov = parse_date(params[:dov])
    if dob && dov
      age_in_months = (dov - dob).days / 1.month
      params[:age_in_months] = age_in_months
    end
    age_in_months
  end

  def compute_gender
    %w(1 2).include?(params[:gender]) ? params[:gender].to_i : nil
  end

  def compute_height
    if params[:height_units] == 'cm'
      params[:height].to_f / 100
    elsif params[:height_units] == 'in'
      params[:height].to_f * 0.0254
    end
  end

  def compute_weight
    if params[:weight_units] == 'kg'
      params[:weight].to_f
    elsif params[:weight_units] == 'lb'
      params[:weight].to_f * 0.453592
    end
  end

  def compute_systolic
    params[:systolic].to_i if params[:systolic].present?
  end

  def compute_diastolic
    params[:diastolic].to_i if params[:diastolic].present?
  end
end
