class OrderController < ApplicationController
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

	def ymlorder_params
    params.require(:order).permit(:ymls)[:ymls]
  end

  def set_order
    order_id = params.require(:order_uniq_id)
    @order = Order.find order_id || Order.new(id: order_id, order_type: 'yml')
  end
end