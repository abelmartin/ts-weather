class ForecasterError < StandardError
  def initialize(msg = 'Error fetching forecast')
    super
  end
end
