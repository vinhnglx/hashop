class ProductService
  attr_reader :products_list

  # Public: Create constructor
  #
  # Parameters
  #
  #   products - List of products
  #   paginator - PaginatorService object
  #   sortable - SortableService object
  #
  # Example
  #
  #   ProductService.new(
  #     Product.includes(:category),
  #     PaginatorService.new(params),
  #     SortableService.new(params),
  #     FilterableService.new(params)
  #   )
  #
  # Returns nothing
  def initialize(products, paginator, sortable, filterable)
    @products_list = products
    @paginator = paginator
    @sortable = sortable
    @filterable = filterable
  end

  # Public: Returns list of products
  #
  # Example
  #
  #   product_service = ProductService.new(
  #                       Product.includes(:category),
  #                       PaginatorService.new(params),
  #                       SortableService.new(params),
  #                       FilterableService.new(params)
  #                     )
  #   product_service.products
  #
  # Returns a list has been sorted, paging and filtering by type if needed.
  def products
    products_list
      .where(@filterable.filter_params)
      .order(@sortable.sort_params)
      .page(@paginator.current_page).per_page(@paginator.page_size)
  end
end
