require 'rails_helper'
RSpec.describe Api::V1::RestaurantsController, type: :controller do
  let(:user) { create(:user) }
  let(:jwt_token) { JWT.encode({ user_id: user.id }, 'your_secret_key', 'HS256') }

  describe 'POST #search' do
    it 'returns a successful response' do
      request.headers['Authorization'] = "Bearer #{jwt_token}"

      post :search, params: { query: 'chinese restaurant' }

      expect(response).to have_http_status(:success)
    end

    it 'returns the search results in JSON format' do
      request.headers['Authorization'] = "Bearer #{jwt_token}"

      post :search, params: { query: 'chinese restaurant' }

      expect(response.content_type).to eq('application/json; charset=utf-8')
    end
  end

  describe 'POST #favorite' do
    let(:restaurant_id) { 'ChIJEZRiXG39YjkRuwqVTDynJ54' }

    it 'toggles the favorite status for the restaurant' do
      request.headers['Authorization'] = "Bearer #{jwt_token}"

      post :favorite, params: { id: restaurant_id }

      expect(response).to have_http_status(:success)
      response_json = JSON.parse (response.body)
      expect(response_json['message']).to eq('Restaurant added to favorites')
      expect(response_json['favorite']).to be_truthy
    end
  end
end
