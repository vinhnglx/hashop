class FilterableService
  attr_reader :filter

  DEFAULT_FILTER = {}.freeze

  # Public: Create constructor
  #
  # Parameter
  #
  #   filter: Hash of parameters want to filter
  #
  # Example
  #
  #   FilterableService.new({filter: { categories: "tool, brush", price: 59 }})
  #
  # Returns nothing
  def initialize(filter = {})
    @filter = filter
    @arel = Product.arel_table
  end

  # Public: Create query
  #
  # Example
  #
  #   filter = FilterableService.new({filter: { categories: "tool, brush", price: 59 }})
  #   filter.filter_params
  #
  # Returns a query object
  def filter_params
    if category_ids.present? && price_parameter
      @arel[:category_id].in(category_ids).and(@arel[:price].lteq(price_parameter))
    elsif category_ids.present?
      @arel[:category_id].in(category_ids)
    elsif price_parameter
      @arel[:price].lteq(price_parameter)
    else
      DEFAULT_FILTER
    end
  end

  # Public: Get price value
  #
  # Example
  #
  #   filter = FilterableService.new({filter: { categories: "tool, brush", price: 59 }})
  #   filter.price_parameter
  #   # => 59
  #
  # Returns price number
  def price_parameter
    filter.key?(:filter) ? filter[:filter][:price] : nil
  end

  # Public: Get categories name
  #
  # Example
  #
  #   filter = FilterableService.new({filter: { categories: "tool, brush", price: 59 }})
  #   filter.categories_parameter
  #   # => "tool", "brush"
  #
  # Returns categories name
  def categories_parameter
    filter.key?(:filter) ? filter[:filter][:categories] : nil
  end

  # Public: Get array of category ids
  #
  # Example
  #
  #   filter = FilterableService.new({filter: { categories: "tool, brush", price: 59 }})
  #   filter.category_ids
  #   # => [3,4]
  #
  # Returns array of category ids
  def category_ids
    if categories_parameter
      names = categories_parameter.tr('"', '').split(", ")
      Category.where(name: names).ids
    end
  end
end
