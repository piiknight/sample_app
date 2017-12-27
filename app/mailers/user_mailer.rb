class UserMailer < ApplicationMailer
  def account_activation user
    @user = user
    mail to: user.email, subject: t("email_activated.subject")
  end

  def password_reset user
    @user = user
    mail to: user.email, subject: t("pass_rs.subject")
  end
end
