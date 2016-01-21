class Restaurants::RegistrationsController < Devise::RegistrationsController
  # rescue_from Restaurantdetail::MultipleVenueError, with: :multiple_venue

  def new
    super
  end

  def create
    super
    if resource.save
      MakeRestaurantDetail.new(resource, 'name' => resource.company_name)
    end
    rescue VenueExistsError
      venue_exists
  end

  protected

  def after_sign_in_path_for(resource)
    restaurant_path(resource)
  end

  private

  def venue_exists
    flash[:error] = 'This venue already exists!'
    # render :new
  end

  # def multiple_venue
  #   flash[:error] = 'Multiple venues from this company name!'
  #   render :new
  # end
end
