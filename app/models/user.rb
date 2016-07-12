# frozen_string_literal: true

# User class defines admins, editors, and viewers
# Users must be approved in order to login
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, and :omniauthable
  devise :database_authenticatable, :registerable, :timeoutable,
         :recoverable, :rememberable, :trackable, :validatable

  # Callbacks
  after_commit :notify_admins_in_background, on: :create

  # Concerns
  include Deletable, Forkable

  # Model Validation
  validates :first_name, :last_name, presence: true

  # User Methods
  def name
    "#{first_name} #{last_name}"
  end

  def name_was
    "#{first_name_was} #{last_name_was}"
  end

  def first_name_and_staff_id
    member = Member.current.find_by email: email
    if member && member.staffid.present?
      [first_name, "<code style=\"color:#fff\">#{member.staffid}</code>"].join(' ').html_safe
    else
      first_name
    end
  end

  # Overriding Devise built-in active_for_authentication? method
  def active_for_authentication?
    super && !deleted? && approved?
  end

  def destroy
    super
    update_column :updated_at, Time.zone.now
  end

  def setup_role?
    admin? || editor?
  end

  def can_view_dsmb_folder?
    admin? || editor? || dsmb_member?
  end

  private

  def notify_admins_in_background
    fork_process :notify_admins
  end

  def notify_admins
    return unless EMAILS_ENABLED
    User.current.where(admin: true).find_each do |admin|
      UserMailer.notify_system_admin(admin, self).deliver_later
    end
  end
end
