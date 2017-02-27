class ApplicationController < ActionController::API
  # Public: Output the routing error
  #
  # Example
  #
  #   get('/api/v230990/02390292')
  #   # => { errors: [ { status: 404, title: 'Not Found' } ] }
  #
  # Returns the JSON error message
  def routing_error
    render json: {
      errors: [
        {
          status: 404,
          title: "Not Found"
        }
      ]
    }, status: 404
  end
end
