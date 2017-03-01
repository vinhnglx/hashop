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
  #   FilterableService.new({filter: { categories: "tool, brush", price: {lt: 59} }})
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
  #   filter = FilterableService.new({filter: { categories: "tool, brush", price: {lt: 59} }})
  #   filter.filter_params
  #
  # Returns a query object
  def filter_params
    if category_ids.present? && price_parameter
      @arel[:category_id].in(category_ids).and(query_price)
    elsif category_ids.present?
      @arel[:category_id].in(category_ids)
    elsif price_parameter
      query_price
    else
      DEFAULT_FILTER
    end
  end

  # Public: Get price value
  #
  # Example
  #
  #   filter = FilterableService.new({filter: { categories: "tool, brush", price: {lt: 59 } }})
  #   filter.price_parameter
  #   # => {lt: 59}
  #
  # Returns Hash price
  def price_parameter
    return nil unless filter.key?(:filter)
    filter[:filter][:price]
  end

  # Public: Handle cases of filter by price
  #
  # Example
  #
  #   fil = FilterableService.new({filter: { categories: "tool, brush", price: {lt: 59 } }})
  #   fil.query_price
  #
  # Returns a query object for price
  def query_price
    return nil if price_parameter.nil?

    if price_parameter.key?(:lt) && price_parameter.key?(:gt)
      @arel[:price].gteq(price_parameter[:gt]).and(@arel[:price].lteq(price_parameter[:lt]))
    elsif price_parameter.key?(:lt)
      @arel[:price].lteq(price_parameter[:lt])
    elsif price_parameter.key?(:gt)
      @arel[:price].gteq(price_parameter[:gt])
    end
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
