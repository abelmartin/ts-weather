class HomeController < ApplicationController
  def index
    # Make the call to the Forecaster service
    if params[:address]
      @forecast = Forecaster.call(params[:address])
      Rails.logger.info @forecast
    end
    respond_to do |format|
      format.html
      format.json { render json: {} }
    end
  end
end
