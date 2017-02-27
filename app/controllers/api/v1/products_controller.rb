module Api
  module V1
    class ProductsController < ApplicationController
      # GET /products
      # GET /products.json
      def index
        render json: Product.includes(:category), include: :category
      end

      # GET /products/1
      # GET /products/1.json
      def show
        product = Product.find(params[:id])
        render json: product, include: :category
      rescue ActiveRecord::RecordNotFound
        product = Product.new
        product.errors.add(:id, "Wrong ID provided")
        render json: product, status: 404, serializer: ActiveModel::Serializer::ErrorSerializer
      end
    end
  end
end
