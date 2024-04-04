# frozen_string_literal: true

# Our sole controller for weather forecasting.
class HomeController < ApplicationController
  def index
    # Make the call to the Forecaster service
    return unless params[:address]

    begin
      @forecast = Rails.cache.fetch(cache_key, expires_in: 30.minutes) do
        Forecaster.call(params[:address])
      end
      @forecast[:cache_ttl] = $redis.ttl(cache_key)
      Rails.logger.info @forecast
    rescue ForecasterError => e
      @error = {
        message: e.message,
        suggested_user_action: 'Please try again with a new request.'
      }
    rescue StandardError
      @error = {
        message: 'A server error occurred.',
        suggested_user_action: 'Please try again later.'
      }
    end
  end

  private

  def cache_key
    "Weather query: #{CGI.escape(params[:address])}"
  end
end
