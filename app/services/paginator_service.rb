class PaginatorService
  attr_reader :page

  PER_PAGE = 5
  CURRENT_PAGE = 1

  # Public: Create constructor
  #
  # Parameter
  #
  #   page: Page parameters
  #
  # Example
  #
  #   PaginatorService.new({number: 2, size: 4})
  #
  # Returns nothing
  def initialize(page)
    @page = page
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
    cur_page = page.key?(:page) ? page[:page][:number] : nil
    (cur_page || CURRENT_PAGE).to_i
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
    pge_size = page.key?(:page) ? page[:page][:size] : nil
    (pge_size || PER_PAGE).to_i
  end
end
