# frozen_string_literal: true

# Displays and caches a single report from Slice.
class Report < ApplicationRecord
  # Constants
  REPORT_TYPES = [
    ["Randomizations by Site", "randomizations_by_site"],
    ["Expressions by Site", "expressions_by_site"]
  ]

  EXPECTED_RANDOMIZATIONS = [
    0,
    0,
    2.6666, 5.33333, 8,
    13.33333, 18.66666, 24,
    31.333333, 38.666666, 46,
    56, 66, 76,
    86.66666666, 97.333333, 108,
    118.6666667, 129.3333333, 140,
    150.6666667, 161.3333333, 172,
    182.6666667, 193.3333333, 204,
    214.6666667, 225.3333333, 236,
    246.6666667, 257.3333333, 268,
    278.6666667, 289.3333333, 300,
    310.6666667, 321.3333333, 332,
    342.6666667, 353.3333333, 364,
    374.6666667, 385.3333333, 396,
    406.6666667, 417.3333333, 428,
    438.6666667, 449.3333333, 460
  ]

  ORDERS = {
    "archived" => "reports.archived desc",
    "active" => "reports.archived",
    "cached" => "reports.last_cached_at",
    "cached desc" => "reports.last_cached_at desc",
    "name" => "reports.name",
    "name desc" => "reports.name desc"
  }
  DEFAULT_ORDER = "reports.archived, reports.name"

  # Concerns
  include Searchable
  def self.searchable_attributes
    %w(name)
  end

  # Accessors
  attr_accessor :row_hashes

  # Callbacks
  after_save :set_report_rows

  # Validations
  validates :name, :report_type, presence: true

  # Relationships
  belongs_to :project
  has_many :report_rows, -> { order(Arel.sql("report_rows.position nulls last")) }, dependent: :destroy

  # Methods

  def refresh!
    return unless project

    (json, status) = Slice::SendJson.get(report_api_url)
    return status unless status.is_a?(Net::HTTPOK)

    update_header_row(json["sites"] || [])
    case report_type
    when "randomizations_by_site"
      create_report_row_results(json["rows"] || [])
    when "expressions_by_site"
      update_report_row_results(json["rows"] || [])
    end
    update last_cached_at: Time.zone.now
    status
  end

  def report_type_name
    REPORT_TYPES.find { |_name, value| value == report_type }&.first
  end

  private

  def report_api_url
    case report_type
    when "randomizations_by_site"
      randomizations_by_site_api_url
    when "expressions_by_site"
      subject_counts_api_url
    end
  end

  def randomizations_by_site_api_url
    "#{project.slice_url}/randomizations.json?sites=#{sites_enabled ? "1" : "0"}"
  end

  def subject_counts_api_url
    expressions = report_rows.pluck(:expression).collect { |exp| "expressions[]=#{CGI.escape(exp)}" }.join("&")
    "#{project.slice_url}/subject-counts.json?#{expressions}&sites=#{sites_enabled ? "1" : "0"}"
  end

  def update_header_row(sites)
    header = [{ label: "Overall" }]
    sites.each do |site|
      header << {
        id: site["id"],
        label: site["number_and_short_name"]
      }
    end
    update header: header
  end

  def create_report_row_results(results)
    report_rows.where(position: nil).delete_all
    results.each_with_index do |result, index|
      report_row = report_rows.where(position: index).first_or_create(label: "Temp")
      report_row.update(label: result["label"], result: result)
    end
    report_rows.where("position >= ?", results.size).delete_all
  end

  def update_report_row_results(results)
    report_rows.each_with_index do |report_row, index|
      report_row.update result: results[index]
    end
  end

  def set_report_rows
    return unless row_hashes&.is_a?(Array)

    row_ids = row_hashes.collect { |row| row[:report_row_id] }.select(&:present?)
    report_rows.where.not(id: row_ids).destroy_all

    row_hashes.each_with_index do |row, index|
      next if row[:label].blank?

      report_row = report_rows.find_by(id: row[:report_row_id])
      if report_row
        report_row.update(
          position: index,
          label: row[:label],
          expression: row[:expression],
          muted: (row[:muted] == "1")
        )
      else
        report_rows.create(
          position: index,
          label: row[:label],
          expression: row[:expression],
          muted: (row[:muted] == "1")
        )
      end
    end
  end
end
