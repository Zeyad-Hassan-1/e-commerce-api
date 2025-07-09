# app/controllers/api/v1/confirmations_controller.rb
module Api
  module V1
    class ConfirmationsController < ApplicationController
      skip_before_action :authorized
      # app/controllers/confirmations_controller.rb
      def confirm_email
        user = User.find_by(confirmation_token: params[:token])

        if user && !user.email_confirmed?
          user.update!(
            email_confirmed: true,
            confirmation_token: nil,
            confirmed_at: Time.current
          )
          render plain: "Your email has been confirmed!"
        else
          render plain: "Invalid or already confirmed", status: :unprocessable_entity
        end
      end



      def resend
        user = User.find_by(email: params[:email])

        if user && !user.email_confirmed?
          user.send(:set_confirmation_token) # regenerate token
          user.save!
          ConfirmationMailer.with(user: user).confirm_email.deliver_later
          render json: { message: "Confirmation email resent." }, status: :ok
        else
          render json: { error: "Invalid or already confirmed email." }, status: :unprocessable_entity
        end
      end
    end
  end
end
