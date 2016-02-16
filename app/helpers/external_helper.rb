# frozen_string_literal: true

module ExternalHelper
  def abbr(abbreviation)
    content_tag :abbr, title: abbreviations[abbreviation][:name] do
      abbreviation
    end
  rescue
    abbreviation
  end

  def abbreviations
    @abbreviations ||= load_yaml('abbreviations')
  end

  private

  def load_yaml(name)
    YAML.load_file(Rails.root.join('lib', 'data', "#{name}.yml"))
  end
end
