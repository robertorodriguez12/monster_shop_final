class User::OrdersController < ApplicationController
  before_action :exclude_admin

  def index
    @orders = current_user.orders
  end

  def show
    @order = current_user.orders.find(params[:id])
  end

  def create
    order = current_user.orders.new
    order.save
      cart.items.each do |item|
        if item.merchant.coupons.best_coupon(cart.count_of(item.id))
          total_price = item.discounted_price(item.merchant.coupon.best_coupons(cart.count_of(item.id)))
        else
          total_price = item.price
        end
        order.order_items.create({
          item: item,
          quantity: cart.count_of(item.id),
          price: total_price
          })
      end
    session.delete(:cart)
    flash[:notice] = "Order created successfully!"
    redirect_to '/profile/orders'
  end

  def cancel
    order = current_user.orders.find(params[:id])
    order.cancel
    redirect_to "/profile/orders/#{order.id}"
  end
end
