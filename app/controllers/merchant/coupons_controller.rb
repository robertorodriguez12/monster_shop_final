class Merchant::CouponsController < Merchant::BaseController
  def index
    @coupons = Merchant.find(current_user.merchant.id).coupons
  end

  def show
    @coupon = Coupon.find(params[:id])
  end

  def new
    @coupon = Coupon.new
  end

  def create
    @coupon = current_user.merchant.coupons.new(coupon_params)
    if @coupon.save
      flash[:success] = 'Coupon Created'
      redirect_to '/merchant/coupons'
    else
      flash[:error] = 'You are missing required fields'
      render :new
    end
  end

  private

  def coupon_params
    params.require(:coupon).permit(:name, :code, :percent_off)
  end
end
