module Api
  module V1
    class ProductsController < ApplicationController
      def index
        render json: Product.includes(:category).all, include: :category
      end
    end
  end
end
