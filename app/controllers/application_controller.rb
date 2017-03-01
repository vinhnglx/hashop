class ApplicationController < ActionController::API
  # Public: Output the routing error
  #
  # Example
  #
  #   get('/api/v230990/02390292')
  #   # => { errors: [ { status: 400, title: 'Bad Request' } ] }
  #
  # Returns the JSON error message
  def routing_error
    render json: {
      errors: [
        {
          status: 400,
          title: "Bad Request"
        }
      ]
    }, status: 400
  end
end
