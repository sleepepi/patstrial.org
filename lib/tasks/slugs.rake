# frozen_string_literal: true

namespace :slugs do
  desc "Remove slugs from deleted models."
  task clear_deleted: :environment do
    puts "Category slugs: #{Category.where(deleted: true).where.not(slug: nil).count}"
    Category.where(deleted: true).update_all(slug: nil)
    puts "Category slugs: #{Category.where(deleted: true).where.not(slug: nil).count}"

    puts "Committee slugs: #{Committee.where(deleted: true).where.not(slug: nil).count}"
    Committee.where(deleted: true).update_all(slug: nil)
    puts "Committee slugs: #{Committee.where(deleted: true).where.not(slug: nil).count}"

    puts "Site slugs: #{Site.where(deleted: true).where.not(slug: nil).count}"
    Site.where(deleted: true).update_all(slug: nil)
    puts "Site slugs: #{Site.where(deleted: true).where.not(slug: nil).count}"
  end
end
