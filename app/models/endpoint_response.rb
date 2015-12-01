class EndpointResponse
  attr_reader :failed

  def initialize(params)
    endpoint = params[:endpoint]
    case endpoint
    when "users"
      @data = User.all
      @failed = nil
    when "purchases"
      @data = Purchase.all
      @failed = nil
    when "cards"
      @data = Card.all
      @failed = nil
    else
      @data = nil
      @failed = "error, somehow something went wrong"
    end

    return @data
  end
end