class Api::V1::UsersController < Api::V1::BaseController
  def update
    @user = User.find(user_params[:id])
    if @user.role == 'driver'
      @user.latitude = user_params[:lat].to_f
      @user.longitude = user_params[:lon].to_f
      if @user.save
        render json: { lat: user_params[:lat], lon: user_params[:lon] }
      end
    end
  end

  private

  def user_params
    params.permit(:lat, :lon, :id)
  end
end
