class UserMailer < ApplicationMailer
  def notify_system_admin(admin, user)
    setup_email
    @admin = admin
    @user = user
    @email_to = admin.email
    mail(to: admin.email,
         subject: "#{user.name} Signed Up",
         reply_to: user.email)
  end

  def status_approved(user)
    setup_email
    @user = user
    @email_to = user.email
    mail(to: user.email,
         subject: "#{user.name}'s Account Approved")
  end
end
