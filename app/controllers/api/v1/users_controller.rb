class Api::V1::UsersController < Api::V1::BaseController
  def update
    @user = User.find(user_params[:id])
    if user_params[:request] == 'clear'
      @user.latitude = nil
      @user.longitude = nil
      if @user.save
        render json: { result: 'cleared' } and return
      end
    end
    if @user.role == 'driver'
      @user.latitude = user_params[:lat].to_f
      @user.longitude = user_params[:lng].to_f
      if @user.save
        render json: { lat: user_params[:lat], lng: user_params[:lng] }
      end
    end
  end

  private

  def user_params
    params.permit(:lat, :lng, :id, :request)
  end
end
