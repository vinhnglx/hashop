class ProductService
  attr_reader :products_list, :paginator, :sortable

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
  #     PaginatorService.new(params[:page]),
  #     SortableService.new(params[:page])
  #   )
  #
  # Returns nothing
  def initialize(products, paginator, sortable)
    @products_list = products
    @paginator = paginator
    @sortable = sortable
  end

  # Public: Returns list of products
  #
  # Example
  #
  #   product_service = ProductService.new(
  #                       Product.includes(:category),
  #                       PaginatorService.new(params[:page]),
  #                       SortableService.new(params[:page])
  #                     )
  #   product_service.products
  #
  # Returns a list has been sorted, paging and filtering by type if needed.
  def products
    products_list.
      order(sortable.sort_params).
      page(paginator.current_page).per_page(paginator.page_size)
  end
end
