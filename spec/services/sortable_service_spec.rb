require 'rails_helper'

RSpec.describe SortableService do
  let!(:sortable_asc) { SortableService.new(sort: 'price') }
  let!(:sortable_desc) { SortableService.new(sort: '-price') }

  describe "#sort_params" do
    it "returns a hash contains sorting's way" do
      expect(sortable_asc.sort_params).to eq("price" => :asc)

      expect(sortable_desc.sort_params).to eq("price" => :desc)
    end
  end

  describe "#allow_sort?" do
    it "returns a boolean value for sorting key is valid or invalid" do
      expect(sortable_asc.allow_sort?("price" => :asc)).to be_truthy

      expect(sortable_asc.allow_sort?("category" => :asc)).to be_falsy
    end
  end

  describe "#transform" do
    it "returns a hash contains the sorting's way" do
      expect(sortable_asc.transform(["price"])).to eq("price" => :asc)

      expect(sortable_asc.transform(["-price"])).to eq("price" => :desc)
    end
  end
end
