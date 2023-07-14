# app/services/restaurant_search_service.rb

class RestaurantService
  attr_accessor :user, :params

  def initialize(current_user, params)
    @user = current_user
    @params = params
  end

  def search
    response = RestClient.get('https://maps.googleapis.com/maps/api/place/textsearch/json', params: {
      query: params[:query],
      key: ENV['GOOGLE_PLACES_API_KEY']
    }) 
  
    # Parse the response and extract required information
    response_body = JSON.parse(response.body)
    results = response_body['results']
    map_search_data(results)
  end

  def toggle_favorite
    return { message: 'Restaurant not found' } unless restaurant_exists?(params[:id])

    favorite = user.favorites.find_or_initialize_by(restaurant_id: params[:id])

    if favorite.persisted?
      favorite.destroy
      message = 'Restaurant removed from favorites'
    else
      favorite.save
      message = 'Restaurant added to favorites'
    end

    { message: message, favorite: favorite.persisted? }
  end

  private

  def map_search_data(results)
    favorite_restaurant_ids = user&.favorites&.pluck(:restaurant_id)
    results.map do |result|
      restaurant_id = result['place_id']
      {
        place_id: restaurant_id,
        name: result['name'],
        location: result['formatted_address'],
        photo_url: result['photos']&.first&.dig('photo_reference'),
      favorite: favorite_restaurant_ids&.include?(restaurant_id)
      }
    end
  end

  def restaurant_exists?(place_id)
    response = RestClient.get('https://maps.googleapis.com/maps/api/place/details/json', params: {
      place_id: place_id,
      key: ENV['GOOGLE_PLACES_API_KEY']
    })
    response_body = JSON.parse(response.body)
    response_body['status'] == 'OK'
  end
end
