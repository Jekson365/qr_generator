module Qrs
  class QrcodesController < ApplicationController
    def create
      result = Qrs::QrcodesService.new(new_code_params, request).create
      render json: result
    end

    def index
      result = Qrs::QrcodesService.new(new_code_params, request).index
      render json: result
    end

    def upload_image
      result = Qrs::QrcodesService.new(new_image_params, request).upload_image
      render json: result
    end

    def concat_images
      result = Qrs::QrcodesService.new(concat_params, request).concat
      render json: result
    end

    def user_images
      result = Qrs::QrcodesService.new(params, request).user_images
      render json: result
    end

    def show_current_final_image
      result = Qrs::QrcodesService.new(params, request).current_final
      render json: result
    end

    private

    def new_code_params
      params.permit(:url, :version, :box_size, :border)
    end

    def concat_params
      params.permit(:position, qr: [:id, :url, :version, :box_size, :border, :user_id, :created_at, :updated_at, :path],
                    image: [:id, :image_path, :user_id, :created_at, :updated_at])
    end

    def new_image_params
      params.permit(:image)
    end
  end
end