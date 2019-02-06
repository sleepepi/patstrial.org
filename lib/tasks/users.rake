# frozen_string_literal: true

namespace :users do
  desc "Migrate first and last names to full name."
  task migrate: :environment do
    User.current.find_each do |user|
      user.update!(
        full_name: "#{user.first_name} #{user.last_name}",
        username: "#{user.first_name.gsub(/[^a-zA-Z0-9]/, "").squish.downcase}#{user.last_name.gsub(/[^a-zA-Z0-9]/, "").squish.downcase}",
        phone: user.member&.phone,
        role: user.member&.role
      )
    rescue ActiveRecord::RecordNotUnique, ActiveRecord::RecordInvalid
      user.update(
        full_name: "#{user.first_name} #{user.last_name}",
        username: "#{user.first_name.gsub(/[^a-zA-Z0-9]/, "").squish.downcase}#{user.last_name.gsub(/[^a-zA-Z0-9]/, "").squish.downcase}1",
        phone: user.member&.phone,
        role: user.member&.role
      )
      puts "User: #{user.first_name} #{user.last_name}: #{ENV["website_url"]}/admin/users/#{user.id}"
    end

    User.where(approved: true).find_each do |user|
      user.update_column :approval_sent_at, user.created_at
    end
  end
end
