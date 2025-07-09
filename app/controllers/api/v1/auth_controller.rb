module Api
  module V1
    class AuthController < ApplicationController
      skip_before_action :authorized, only: [ :login ]
      rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found

      # app/controllers/api/v1/auth_controller.rb
      def login
        user = User.find_by(email: params[:email])

        if user&.authenticate(params[:password])
          if user.email_confirmed?
            token = encode_token(user_id: user.id)
            render json: { user: UserSerializer.new(user), token: token }, status: :ok
          else
            render json: { error: "Please confirm your email before logging in" }, status: :unauthorized
          end
        else
          render json: { error: "Invalid email or password" }, status: :unauthorized
        end
      end


      private

      def login_params
        params.permit(:username, :password, :email)
      end

      def handle_record_not_found(e)
        render json: { message: "User doesn't exist" }, status: :unauthorized
      end
    end
  end
end
