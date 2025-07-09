module Api
  module V1
    class UsersController < ApplicationController
      skip_before_action :authorized, only: [ :create ]
      rescue_from ActiveRecord::RecordInvalid, with: :handle_invalid_record

      def create
        user = User.create!(user_params) # before_create runs automatically and sets confirmation_token

        # Send email with the generated token
        ConfirmationMailer.with(user: user).confirm_email.deliver_now

        @token = encode_token(user_id: user.id)
        render json: {
          user: UserSerializer.new(user),
          token: @token
        }, status: :created
      end


      def me
        render json: current_user, status: :ok
      end

      def confirm_email
        user = User.find_by(confirmation_token: params[:token])

        if user && user.confirmed_at.nil?
          user.update(confirmed_at: Time.current, confirmation_token: nil)
          render json: { message: "Email confirmed successfully!" }, status: :ok
        else
          render json: { error: "Invalid or expired token" }, status: :unprocessable_entity
        end
      end

      private

      def user_params
        params.permit(:username, :password, :bio, :email)
      end

      def handle_invalid_record(e)
        render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
      end
    end
  end
end
