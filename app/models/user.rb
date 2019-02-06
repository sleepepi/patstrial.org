# frozen_string_literal: true

# Defines the user model, relationships, and permissions.
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, and :omniauthable
  devise :database_authenticatable, :registerable, :timeoutable,
         :recoverable, :rememberable, :trackable, :validatable

  # Callbacks
  after_commit :notify_admins_in_background, on: :create

  # Uploaders
  mount_uploader :profile_picture, ResizableImageUploader

  # Constants
  ORDERS = {
    "activity desc" => "(CASE WHEN (users.current_sign_in_at IS NULL) THEN users.created_at ELSE users.current_sign_in_at END) desc",
    "activity" => "(CASE WHEN (users.current_sign_in_at IS NULL) THEN users.created_at ELSE users.current_sign_in_at END)",
    "logins desc" => "users.sign_in_count desc",
    "logins" => "users.sign_in_count"
  }
  DEFAULT_ORDER = "(CASE WHEN (users.current_sign_in_at IS NULL) THEN users.created_at ELSE users.current_sign_in_at END) desc"

  # Concerns
  include Deletable
  include Forkable
  include Squishable
  squish :full_name, :keywords, :phone, :role

  include Strippable
  strip :username

  include Searchable
  def self.searchable_attributes
    %w(full_name email username)
  end

  include PgSearch
  multisearchable against: [:full_name, :email, :username, :keywords, :phone, :role], unless: :deleted?

  # Validations
  validates :full_name, presence: true
  validates :full_name, format: { with: /\A.+\s.+\Z/, message: "must include first and last name" }
  validates :username, presence: true
  validates :username, format: { with: /\A[a-zA-Z0-9]+\Z/i, message: "may only contain letters or digits" },
                       exclusion: { in: %w(new edit show create update destroy) },
                       allow_blank: true,
                       uniqueness: { case_sensitive: false }

  # User Methods
  def staff_id
    member&.staffid
  end

  def member
    Member.current.find_by email: email
  end

  def check_approval_email
    return unless approved? && approval_sent_at.nil?

    update(approval_sent_at: Time.zone.now)
    send_approval_email_in_background!
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

  def can_view_unblinded_folder?
    admin? || editor? || unblinded?
  end

  private

  def notify_admins_in_background
    fork_process :notify_admins
  end

  def notify_admins
    return unless EMAILS_ENABLED

    User.current.where(admin: true).find_each do |admin|
      RegistrationMailer.user_registered(admin, self).deliver_now
    end
  end

  def send_approval_email_in_background!
    fork_process :send_approval_email!
  end

  def send_approval_email!
    RegistrationMailer.account_approved(self).deliver_now if EMAILS_ENABLED
  end
end
