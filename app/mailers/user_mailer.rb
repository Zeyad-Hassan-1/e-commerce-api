class UserMailer < ApplicationMailer
  default from: "store@example.com"

  def reset_password_email
    @user = params[:user]
    @token = @user.reset_password_token
    @url = "http://localhost:3000/password-reset?token=#{@token}" # Frontend URL

    mail(to: @user.username, subject: "Reset your password")
  end
end
