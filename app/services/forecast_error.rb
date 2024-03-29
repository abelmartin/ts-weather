class ForecastError < StandardError
  def initialize(msg = 'Invalid location')
    super
  end
end
