# frozen_string_literal: true

# Displays and caches a single report from Slice.
class Report < ApplicationRecord
  # Accessors
  attr_accessor :row_hashes

  # Callbacks
  after_save :set_report_rows

  # Validations
  validates :name, presence: true

  # Relationships
  belongs_to :project
  has_many :report_rows, -> { order(Arel.sql("report_rows.position nulls last")) }, dependent: :destroy

  # Methods

  def refresh!
    return unless project

    (json, status) = Slice::SendJson.get(subject_counts_api_url)
    return status unless status.is_a?(Net::HTTPOK)

    update_header_row(json["sites"] || [])
    update_report_row_results(json["rows"] || [])
    update last_cached_at: Time.zone.now
    status
  end

  private

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
