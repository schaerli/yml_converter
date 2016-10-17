class YmlController < ApplicationController
  before_filter :set_order, only: [:create]

  def create
    @order.ymls.build(yml: ymlorder_params)


    if @order.save
      # if params[:file_id].to_i == (params[:count_files].to_i - 1 )
      #   foo = @order.create_xlsx_from_ymls
      # end

      respond_to do |format|
        format.html { 
          redirect_to yml_path(@order.id, format: :xls) if params[:file_id].to_i == (params[:count_files].to_i - 1 )
        }
        # format.html { send_data foo.read, filename: "foo.xlsx", type: "application/vnd.ms-excel" }
        format.json { 
          # render json: {initialPreview: []}
          # if params[:file_id].to_i == (params[:count_files].to_i - 1 )
            # @url =  request.protocol + request.host_with_port + yml_path(@order.id, format: :xls)
            # render json: {initialPreview: []}
          # else
          render json: {initialPreview: []}
          # end
        }
      end
    else
      respond_to do |format|
        format.json { render json: { error: 'Sorry something went wrong! -- Aiii --'}}
      end
    end
  end

  def show
    @order = Order.find params[:id]

    xls_string = @order.create_xlsx_from_ymls

    respond_to do |format|
      format.xls { send_data xls_string.read, filename: "foo.xls", type: "application/vnd.ms-excel"}
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
