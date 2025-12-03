module Api
  module V1
    class ContentsController < ApplicationController
      before_action :set_content, only: %i[update destroy]

      def create
        content = current_user.contents.new(content_params)
        if content.save
          render json: { data: ContentSerializer.new(content).as_json }, status: :created
        else
          render json: { errors: content.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def index
        contents = Content.all
        render json: { data: ActiveModelSerializers::SerializableResource.new(contents, each_serializer: ContentSerializer) }, status: :ok
      end

      def destroy
        @content.destroy
        render json: { message: "Deleted" }, status: :ok
      end

      def update
        if @content.update(content_params)
          render json: { data: ContentSerializer.new(@content).as_json }, status: :ok
        else
          render json: { errors: @content.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def content_params
        params.permit(:title, :body)
      end

      def set_content
        @content = current_user.contents.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { errors: "Content not found" }, status: :not_found
      end
    end
  end
end
