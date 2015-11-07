class YmlController < ApplicationController
  
  def index
    @all_ymls    = Yml.all    
    respond_to do |format|
      format.html
      format.json do 
        render :json => @all_ymls.collect { |p| p.to_jq_upload }.to_json
      end
    end
  end

  def create
    binding.pry
  end

  def show
  end
end