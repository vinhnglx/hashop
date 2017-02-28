class SortableService
  attr_reader :sort

  DEFAULT_SORTING = { created_at: :desc }.freeze
  SORTABLE_FIELDS = ['price'].freeze

  # Public: Create constructor
  #
  # Parameter
  #
  #   sort: Sort paramter
  #
  # Example
  #
  #   SortableService.new({sort: '-price'})
  #
  # Returns nothing
  def initialize(sort)
    @sort = sort[:sort]
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
    fields = sort.to_s.split(",")

    allow_sort?(transform(fields)) ? transform(fields) : DEFAULT_SORTING
  end

  # Public: Check sorting key is valid or not when compare with SORTABLE_FIELDS
  #
  # Parameter
  #
  #   sorting_way: A hash contains sorting's way
  #
  # Example
  #
  #   allow_sort?({price: :desc})
  #   # => true
  #
  # Returns boolean
  def allow_sort?(sorting_way)
    sorting_way.keys.select { |key| SORTABLE_FIELDS.include?(key) }.present?
  end

  # Public: Convert an array of fields to a hash that contain the sorting's way.
  #
  # Parameter
  #
  #   fields: Array of fields need to be convert
  #
  # Example
  #
  #   transform(["price"])
  #   # => {price: :asc}
  #
  # Returns a hash contains the sorting's way
  def transform(fields)
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
