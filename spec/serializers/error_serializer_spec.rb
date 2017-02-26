require 'rails_helper'

RSpec.describe ErrorSerializer do
  before do
    @product = Product.new
    @product.errors.add(:id, "Wrong ID provided")
  end

  it "should response the error object" do
    error = described_class.serialize(@product, 404)
    expect(error.size).to eq 1
    expect(error.first[:status]).to eq 404
    expect(error.first[:id]).to eq :id
    expect(error.first[:detail]).to eq "Wrong ID provided"
  end
end
