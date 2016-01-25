class Restaurants::RegistrationsController < Devise::RegistrationsController
  def new
    super
  end

  def create
    build_resource(sign_up_params)

    rd = MakeRestaurantDetail.new(resource, 'name' => resource.company_name)
    if resource.valid? && rd.valid?
      resource.save
    end
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_flashing_format?
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      if !rd.exists_valid
        flash.now[:error] = 'This venue already exists!'
      elsif !rd.multiple_valid
        flash.now[:error] = 'Multiple venues with this company name!'
      elsif !rd.match_valid
        flash.now[:error] = "Company name doesn't exist!"
      end
      clean_up_passwords resource
      set_minimum_password_length
      render :new
    end
  end

  protected

  def after_sign_up_path_for(resource)
    restaurantdetail_path(resource.restaurantdetail)
  end
end
