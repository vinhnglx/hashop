module API
  module V1
    class ProductsController < ApplicationController
      def index
        render json: Product.all, include: :category
      end
    end
  end
end
