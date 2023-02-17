class UserNotifierMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_notifier_mailer.signup_alert.subject
  #
  def signup_alert(user_data)

    @user_name = user_data.first_name

    mail to: user_data.email , subject: "You account was created!"
  end

  def send_password(user_data)
    @user_name = user_data.first_name
    @user_password = user_data.password
    mail to: user_data.email , subject: "New Password"
  end


  def reset_password(user_data)
    @user_name = user_data.first_name
    mail to: user_data.email , subject: "Password has been reset"
  end
end
