module Api
  module V1
    class ProductsController < ApplicationController
      def index
        render json: Product.includes(:category), include: :category
      end

      def show
        render json: Product.find(params[:id]), include: :category
      end
    end
  end
end
