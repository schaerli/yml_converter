class OrderController < ApplicationController

  def index
  end

  def create
    order = Order.new(order_type: 'yml')

    if order.save
      respond_to do |format|
        format.json {render json: order}
      end
    else
      respond_to do |format|
        format.json {render json: "error"}
      end
    end
  end

end