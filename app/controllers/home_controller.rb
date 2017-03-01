require 'rails/application_controller'

class HomeController < Rails::ApplicationController
  def index
    render json: {
      "products_url": "/api/v1/products?{sort,page[number],page[size],filter[price][lt],filter[price][gt],filter[categories]}",
      "product_url": "/api/v1/products/{id}"
    }, status: :ok
  end
end
