class RestaurantsController < ApplicationController
  before_action :authenticate_restaurant!

  def show
    @restaurant = Restaurant.find(params[:id])
  end
end
