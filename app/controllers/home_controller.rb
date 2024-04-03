class HomeController < ApplicationController
  def index
    # Make the call to the Forecaster service
    if params[:address]
      # expiry_seconds: $redis.ttl(cache_key)
      begin
        @forecast = Rails.cache.fetch(cache_key, expires_in: 30.minutes) do
          Forecaster.call(params[:address])
        end
        @forecast[:cache_ttl] = $redis.ttl(cache_key)
        Rails.logger.info @forecast
      rescue ForecastError => e
        @error = {
          message: e.message,
          suggested_user_action: 'Please try again with a new request.'
        }
      rescue Exception => e
        @error = {
          message: 'A server error occurred.',
          suggested_user_action: 'Please try again later.'
        }
      end
    end
    respond_to do |format|
      format.html
      format.json { render json: {} }
    end
  end

  private

  def cache_key
    CGI::escape(params[:address])
  end
end
