require 'rails_helper'

RSpec.describe PaginatorService do
  let!(:paginator) { PaginatorService.new(page: { number: 2, size: 1 }) }

  describe "#current_page" do
    it "returns current page" do
      expect(paginator.current_page).to eq 2
    end
  end

  describe "#page_size" do
    it "returns page size" do
      expect(paginator.page_size).to eq 1
    end
  end
end
