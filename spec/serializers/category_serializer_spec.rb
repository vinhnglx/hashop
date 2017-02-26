require 'rails_helper'

RSpec.describe CategorySerializer do
  let!(:category) { create(:category) }
  let!(:serializer) { CategorySerializer.new(category) }
  let!(:serialization) { ActiveModelSerializers::Adapter.create(serializer) }

  subject { JSON.parse(serialization.to_json) }

  it "should response expected Category attributes" do
    jdata = subject['data']['attributes']
    expect(jdata['name']).to eq category.name
  end
end
