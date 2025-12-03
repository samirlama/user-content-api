module Api
  module V1
    class ApplicationController < ActionController::API
      before_action :authorize_request
      before_action :set_current_user
      def authorize_request
        header = request.headers['Authorization']
        header = header.split(' ').last if header
        begin
          @decoded = JsonWebToken.decode(header)
        rescue JWT::ExpiredSignature
          render json: { errors: "Token has expired" }, status: :unauthorized
        rescue JWT::DecodeError
          render json: { errors: "Invalid token" }, status: :unauthorized
        end
      end

      def set_current_user
        return unless @decoded

        begin
          @current_user = User.find(@decoded[:user_id])
        rescue ActiveRecord::RecordNotFound
          render json: { errors: "User not found" }, status: :unauthorized
        end
      end

      def current_user
        @current_user
      end

      def user_signed_in?
        !!current_user
      end
    end
  end
end