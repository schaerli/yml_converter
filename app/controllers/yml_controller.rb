class YmlController < ApplicationController
  
  def index
    @ymlorder  = Order.new(order_type: 'yml')
    @xlsxorder = Order.new(order_type: 'xlsx')
  end

end