module Calculators
  # Calculates Body Mass Index Z-Score
  # References:
  #  http://www.cdc.gov/growthcharts/percentile_data_files.htm
  #  http://www.cdc.gov/growthcharts/data/zscore/statage.csv
  class BloodPressurePercentile
    # def self.compute_bmi(height_in_meters, weight_in_kilogram)
    #   weight_in_kilogram / height_in_meters**2
    # end

    def self.lookup_lms(gender, age_in_months)
      l = m = s = 0
      csv_path = Rails.root.join('lib', 'data', 'calculators', 'statage.csv')
      CSV.parse(File.open(csv_path, 'r:iso-8859-1:utf-8') { |f| f.read }) do |line|
        if line[0].to_s == gender.to_s && line[1].to_f.floor == age_in_months.floor
          return { l: line[2].to_f, m: line[3].to_f, s: line[4].to_f }
        end
      end
      { l: l, m: m, s: s }
    end

    def self.compute_zscore(height, l, m, s)
      if l != 0
        (((height / m)**l) - 1) / (l * s)
      elsif l == 0
        Math.log(height / m) / s
      end
    end

    def self.compute_percentile(zscore)
    end
  end
end
