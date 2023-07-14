# app/controllers/restaurants_controller.rb
module Api
  module V1
    class RestaurantsController < ApplicationController
      before_action :authenticate_user

      def search
          results = RestaurantService.new(current_user, params).search
          render json: results
      end

      def favorite
        result = RestaurantService.new(current_user, params).toggle_favorite
        render json: result
      end
    end
  end
end
