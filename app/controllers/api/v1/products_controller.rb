module Api
  module V1
    class ProductsController < ApplicationController
      before_action :_product, only: :show

      def index
        render json: Product.includes(:category), include: :category
      end

      def show
        render json: @product, include: :category
      end

      private

      # Private: This method will be called before actions
      #
      # Example
      #
      #   _product
      #   # => #<Product id: 23, name: "xxx", price: xxx, sale_price: xxx ...>
      #
      # Returns a specific product
      def _product
        begin
          @product = Product.find(params[:id])
        rescue ActiveRecord::RecordNotFound
          product = Product.new
          product.errors.add(:id, "Wrong ID provided")
          respond_with_errors(product, 404)
        end
      end
    end
  end
end
