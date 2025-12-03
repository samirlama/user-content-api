module Api
  module V1
    class SessionsController < ApplicationController
      skip_before_action :authorize_request, only: [:create]

      def create
        user = User.find_by(email: auth_params[:email])
        if user&.authenticate(auth_params[:password])
          token = JsonWebToken.encode(user_id: user.id)
          render json: { data: UserSerializer.new(user, token: token)}, status: :ok
        else
          render json: { error: 'Invalid credentials' }, status: :unauthorized
        end
      end

      def auth_params
        params.require(:auth).permit(:email, :password)
      end
    end
  end
end