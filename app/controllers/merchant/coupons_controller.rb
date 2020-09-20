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
      redirect_to '/merchant/coupons'
      flash[:success] = 'Coupon Created'
    else
      flash[:error] = 'You are missing required fields'
      render :new
    end
  end

  def edit
    @coupon = Coupon.find(params[:id])
  end

  def update
    @coupon = Coupon.find(params[:id])
    @coupon.update(coupon_params)
    if @coupon.save
      flash[:success] = "Your coupon has been updated."
      redirect_to "/merchant/coupons"
    else
      flash[:error] = "You are missing fields"
      render :edit
    end
  end

  def destroy
    @coupon = Coupon.find(params[:id])
    @coupon.delete
    flash[:success] = "Coupon deleted"
    redirect_to "/merchant/coupons"
  end

  private

  def coupon_params
    params.require(:coupon).permit(:name, :code, :percent_off)
  end
end
