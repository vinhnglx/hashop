class ApplicationController < ActionController::API
  private

  # Private: Output the error message
  #
  # Parameters
  #
  #   object - Record object error
  #   status - http status code
  #
  # Example
  #
  #   respond_with_errors(product, 404)
  #   # => { errors: [ status: 404, id: 'id',
  #                    detail: "Wrong ID provided"] }
  #
  # Returns error object with JSON format
  def respond_with_errors(object, status)
    render json: {
      errors: ErrorSerializer.serialize(object, status)
    }, status: status
  end
end
