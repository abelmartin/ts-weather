# frozen_string_literal: true

# Custom error class for the Forecaster service
class ForecasterError < StandardError
  def initialize(msg = 'Error fetching forecast')
    super
  end
end
