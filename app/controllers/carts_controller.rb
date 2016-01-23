class CartsController < ApplicationController
  def update
    @cart = Cart.find(params[:id])
    if @cart.update_attributes(cart_params)
      cart_params['cartitems_attributes'].each do |_key, value|
        ci = Cartitem.find_or_initialize_by(id: value['id'])
        if value['quantity'] == "0"
          ci.destroy
        else
          ci.update_attributes(value)
        end
      end
      redirect_to restaurant_path(@cart.restaurant)
    end
  end

  private

  def cart_params
    params.require(:cart).permit(:id,
      cartitems_attributes: [:id, :cart_id, :item_id, :quantity])
  end
end
