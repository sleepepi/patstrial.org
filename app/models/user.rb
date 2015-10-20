# User class defines admins, editors, and viewers
# Users must be approved in order to login
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, and :omniauthable
  devise :database_authenticatable, :registerable, :timeoutable,
         :recoverable, :rememberable, :trackable, :validatable

  # Callbacks
  after_create :notify_admins_in_background

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

  # Overriding Devise built-in active_for_authentication? method
  def active_for_authentication?
    super && !deleted? && approved?
  end

  def destroy
    super
    update_column :updated_at, Time.zone.now
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
