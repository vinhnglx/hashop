class ErrorSerializer
  # Public: Mapping object and status
  #
  # Parameters
  #
  #   object - Record object error
  #   status - http status code
  #
  # Example
  #
  #   ErrorSerializer.serialize(product, 404)
  #   # => { status: 404, id: 'id', detail: "Wrong ID provided" }
  #
  # Returns a JSON error object
  def self.serialize(object, status)
    object.errors.messages.map do |field, errors|
      errors.map do |error_message|
        {
          status: status,
          id: field,
          detail: error_message
        }
      end
    end.flatten
  end
end
