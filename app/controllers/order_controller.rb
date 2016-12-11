class OrderController < ApplicationController

  def index
  end

  def create
    if params.include?("type")
      order = Order.new(order_type: 'xls')
    else
      order = Order.new(order_type: 'yml')
    end

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