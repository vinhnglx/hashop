class PaginatorService
  attr_reader :page

  PER_PAGE = 5.freeze

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
    (page.dig(:page, :number) || 1).to_i
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
    (page.dig(:page, :size) || PER_PAGE).to_i
  end
end
