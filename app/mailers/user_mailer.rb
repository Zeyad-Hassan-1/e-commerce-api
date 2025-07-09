class UserMailer < ApplicationMailer
  def reset_password_email
    @user = params[:user]
    @token = @user.reset_password_token
    @url = "http://localhost:3000/password-reset?token=#{@token}" # Frontend URL

    mail(to: @user.email, subject: "Reset your password")
  end
end
