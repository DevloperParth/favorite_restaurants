# spec/services/restaurant_search_service_spec.rb
require 'rails_helper'

RSpec.describe RestaurantService do
  let(:current_user) { create(:user) }
  let(:params) { { query: 'chinese restaurant' } }
  let(:service) { described_class.new(current_user, params) }

  describe '#search' do
    it 'returns the search results' do
      # Stub the RestClient.get method to return sample response data
      allow(RestClient).to receive(:get).and_return(
        OpenStruct.new(
          body: {
            'results' => [
              { 'place_id' => 'place_id_1', 'name' => 'Restaurant 1', 'formatted_address' => 'Address 1', 'photos' => [{ 'photo_reference' => 'photo_ref_1' }] },
              { 'place_id' => 'place_id_2', 'name' => 'Restaurant 2', 'formatted_address' => 'Address 2', 'photos' => [{ 'photo_reference' => 'photo_ref_2' }] }
            ]
          }.to_json
        )
      )

      results = service.search

      expect(results).to be_an(Array)
      expect(results.size).to eq(2)

      expect(results[0]).to include(
        place_id: 'place_id_1',
        name: 'Restaurant 1',
        location: 'Address 1',
        photo_url: 'photo_ref_1',
        favorite: false
      )
      expect(results[1]).to include(
        place_id: 'place_id_2',
        name: 'Restaurant 2',
        location: 'Address 2',
        photo_url: 'photo_ref_2',
        favorite: false
      )
    end
  end

  describe '#toggle_favorite' do
    context 'when restaurant exists' do
      let(:restaurant_id) { 'place_id_1' }

      before do
        allow(service).to receive(:restaurant_exists?).and_return(true)
      end

      it 'toggles the favorite status' do
        expect(service.toggle_favorite[:message]).to eq('Restaurant added to favorites')
      end
    end

    context 'when restaurant does not exist' do
      let(:restaurant_id) { 'non_existing_place_id' }

      before do
        allow(service).to receive(:restaurant_exists?).and_return(false)
      end

      it 'returns an error message' do
        expect(service.toggle_favorite).to eq({ message: 'Restaurant not found' })
      end
    end
  end
end
