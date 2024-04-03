class HomeController < ApplicationController
  def index
    # Make the call to the Forecaster service
    if params[:address]
      # expiry_seconds: $redis.ttl(cache_key)
      @forecast = Forecaster.call(params[:address])
      Rails.logger.info @forecast
    end
    respond_to do |format|
      format.html
      format.json { render json: {} }
    end
  end

  private

  def cache_key
    URI.encode_www_form(params[:address])
  end
end
