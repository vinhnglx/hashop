class ProductService
  attr_reader :products_list, :params

  DEFAULT_SORTING = { created_at: :desc }.freeze
  SORTABLE_FIELDS = ['price'].freeze

  PER_PAGE = 5.freeze

  # Public: Create constructor
  #
  # Parameters
  #
  #   products - List of products
  #   params - Product's parameters
  #
  # Example
  #
  #   ProductService.new(Product.includes(:category), params)
  #
  # Returns nothing
  def initialize(products, params)
    @products_list = products
    @params = params
  end

  # Public: Sorting products
  #
  # Example
  #
  #   product_service = ProductService.new(Product.includes(:category), params)
  #   product_service.products
  #
  # Returns sorted list of products
  def products
    products_list.order(sort_params).page(current_page).per_page(page_size)
  end

  # Public: A hash that contain sorting's way
  #
  # Example
  #
  #   sort_params
  #   # => {price: :desc}
  #
  # Returns a hash that contain sorting's way
  def sort_params
    fields = params[:sort].to_s.split(",")

    _allow_sort?(_transform(fields)) ? _transform(fields) : DEFAULT_SORTING
  end

  # Public: Get page number from parameter or default value
  #
  # Example
  #
  #   current_page
  #   # => 5
  #
  # Returns page number
  def current_page
    (params.dig(:page, :number) || 1).to_i
  end

  # Public: Get page size from parameter or default value
  #
  # Example
  #
  #   page_size
  #   # => 10
  #
  # Returns page size
  def page_size
    (params.dig(:page, :size) || PER_PAGE).to_i
  end

  private

    # Private: Check sorting key is valid or not when compare with SORTABLE_FIELDS
    #
    # Parameter
    #
    #   sorting_way: A hash contains sorting's way
    #
    # Example
    #
    #   _allow_sort?({price: :desc})
    #   # => true
    #
    # Returns boolean
    def _allow_sort?(sorting_way)
      sorting_way.keys.select { |key| SORTABLE_FIELDS.include?(key) }.present?
    end

    # Private: Convert an array of fields to a hash that contain the sorting's way.
    #
    # Parameter
    #
    #   fields: Array of fields need to be convert
    #
    # Example
    #
    #   _transform(["price"])
    #   # => {price: :asc}
    #
    # Returns a hash containing the sorting's way
    def _transform(fields)
      fields.each_with_object({}) do |field, hash|
        if field.start_with?("-")
          field = field[1..-1]
          hash[field] = :desc
        else
          hash[field] = :asc
        end
      end
    end
end
