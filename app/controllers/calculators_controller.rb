# Publicly available calculators
class CalculatorsController < ApplicationController
  def bmi_zscore
  end

  def bmi_zscore_calculate
    dob = parse_date(params[:dob])
    dov = parse_date(params[:dov])
    if dob && dov
      age_in_months = (dov - dob).days / 1.month
      params[:age_in_months] = age_in_months
    end

    gender = nil
    if params[:gender] == '1'
      gender = 1
    elsif params[:gender] == '2'
      gender = 2
    end

    height = nil
    if params[:height_in_cm].present?
      height = params[:height_in_cm].to_f / 100
    elsif params[:height_in_in].present?
      height = params[:height_in_in].to_f * 0.0254
    end

    weight = nil
    if params[:weight_in_kg].present?
      weight = params[:weight_in_kg].to_f
    elsif params[:weight_in_lb].present?
      weight = params[:weight_in_lb].to_f * 0.453592
    end

    if age_in_months && age_in_months >= 24 && gender && height && height > 0 && weight && weight > 0
      bmi = Calculators::BmiZscore.compute_bmi(height, weight)
      params[:bmi] = bmi
      lms = Calculators::BmiZscore.lookup_lms(gender, age_in_months)
      zscore = Calculators::BmiZscore.compute_zscore(bmi, lms[:l], lms[:m], lms[:s])

      params[:l] = lms[:l]
      params[:m] = lms[:m]
      params[:s] = lms[:s]
      params[:zscore] = zscore

      redirect_to calculators_bmi_zscore_result_path(zscore_params)
    else
      @error = 'Please enter all parameters.'
      render :bmi_zscore
    end
  end

  def bmi_zscore_result
  end

  def blood_pressure_percentile
  end

  private

  def zscore_params
    params.permit(:weight_in_kg, :weight_in_lb, :height_in_in, :height_in_cm, :gender, :dob, :dov, :age_in_months, :l, :m, :s, :zscore, :bmi)
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
end
