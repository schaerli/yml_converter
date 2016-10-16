class YmlController < ApplicationController
  before_filter :set_order

  def create
    @order.ymls.build(yml: ymlorder_params)

    if @order.save
      respond_to do |format|
        format.json { render json: {initialPreview: []}}
      end
    else
      respond_to do |format|
        format.json { render json: { error: 'Sorry something went wrong! -- Aiii --'}}
      end
    end

  end

  private

  def set_order
    @order = Order.find params[:order_id].to_i
  end

  def ymlorder_params
    params.require(:order).permit(:ymls)[:ymls]
  end


end
