class Order::YmlController < ApplicationController
  before_filter :set_order, only: :create

  def create
  end  

  private

  def set_order
    binding.pry
    order_id = params.require(:order_id)
    @order   = Order.find order_id
  end
end