class Api::V1::PasswordResetsController < ApplicationController
  skip_before_action :authorized

  def create
    user = User.find_by(username: params[:email])
    if user
      user.generate_password_reset_token!
      UserMailer.with(user: user).reset_password_email.deliver_now
      render json: { message: "Password reset instructions sent to your email" }
    else
      render json: { error: "Email not found" }, status: :not_found
    end
  end

  def update
    user = User.find_by(reset_password_token: params[:token])
    if user&.password_token_valid?
      if user.reset_password!(params[:password])
        render json: { message: "Password has been reset successfully" }
      else
        render json: { error: "Unable to reset password" }, status: :unprocessable_entity
      end
    else
      render json: { error: "Invalid or expired token" }, status: :unauthorized
    end
  end
end
