Spree::Admin::StockItemsController.class_eval do
  def index
    @stock_location = params[:stock_location] ? Spree::StockLocation.find_by(id: params[:stock_location]) : Spree::StockLocation.first
    respond_to do |format|
      format.html
      # format.json { render json: UserDatatable.new(params) }
      format.json { render json: StockItemDatatable.new(params, stock_location: @stock_location) }
    end
  end
end