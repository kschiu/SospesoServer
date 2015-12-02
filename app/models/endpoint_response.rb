class EndpointResponse
  attr_reader :failed

  def initialize(params)
    endpoint = params[:endpoint]
    case endpoint
    when "users"
      if !(params.include?(:id) or params.include?(:related_endpoint))
        @data = User.where('id = ?', 2)
      elsif !params.include?(:related_endpoint)
        @data = User.where('id = ?', 3)
      else
        # params[:related_endpoint].singularize.classify.constantize
        @data = User.where('id = ?', 4)
      end
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