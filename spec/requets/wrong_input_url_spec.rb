require 'rails_helper'

RSpec.describe "Request: Input wrong URLs", type: :request do
  before do
    get '/api/v23902/230492302'
  end

  it "returns json error not found url" do
    expect(response).to have_http_status(:not_found)
    jdata = JSON.parse response.body
    expect(jdata['errors'][0]['title']).to eq "Not Found"
  end
end
