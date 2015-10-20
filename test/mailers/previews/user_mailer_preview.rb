# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def notify_system_admin
    admin = User.where(admin: true).first
    user = User.first
    UserMailer.notify_system_admin(admin, user)
  end

  def status_approved
    user = User.first
    UserMailer.status_approved(user)
  end
end
