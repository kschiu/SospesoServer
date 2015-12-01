class EndpointRequest
  attr_reader :failed

  def initialize(params)
    @params = params
    @endpoint = params[:endpoint]
    @failed = "error, that's not a valid endpoint" unless self.valid?
  end

  def valid?
    endpoints = ["users", "purchases", "cards"]
    return endpoints.include?(@endpoint)
  end
end