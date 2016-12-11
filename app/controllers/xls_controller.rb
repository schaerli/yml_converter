class XlsController < ApplicationController
  before_filter :set_order, only: [:create]

  def index
  end

  def create
    @order.xlsxs.build(xls: xlsorder_params)


    if @order.save

      respond_to do |format|
        format.html { 
          redirect_to xls_path(@order.id, format: :xls) if params[:file_id].to_i == (params[:count_files].to_i - 1 )
        }
        format.json { 
          render json: {initialPreview: []}
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

    yml_string = @order.create_yml_from_xlsx

    respond_to do |format|
      format.yml { send_data yml_string.read, filename: "yml_converter.yml", type: "application/vnd.ms-excel"}
    end
  end

  private

  def set_order
    @order = Order.find params[:order_id].to_i
  end

  def xlsorder_params
    params.require(:order).permit(:xlsx)[:xlsx]
  end


end
