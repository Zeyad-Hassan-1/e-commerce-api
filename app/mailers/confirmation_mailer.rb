class ConfirmationMailer < ApplicationMailer
  def confirm_email
    @user = params[:user]
    @token = @user.confirmation_token

    mail(
      to: @user.email,
      subject: "Confirm your email address"
    )
  end
end
