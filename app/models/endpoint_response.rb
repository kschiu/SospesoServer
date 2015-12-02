class EndpointResponse
  attr_reader :failed

  def initialize(params)
    @object = params[:endpoint].singularize.classify.constantize.all
    # puts "nigga"
    @data = @object
    puts @data
    # puts "wtf"
    @failed = nil
    # puts "fuck this shit"
    return @data

    # endpoint = params[:endpoint]
    # case endpoint
    # when "users"
    #   # just return all of the users
    #   if params[:id].nil? and params[:related_endpoint].nil?
    #     @data = User.where('id = ?', 2)
    #   # return just one of the users
    #   elsif params[:related_endpoint].nil?
    #     @data = User.where('id = ?', 3)
    #   # return the purchases related to a user
    #   else
    #     # params[:related_endpoint].singularize.classify.constantize
    #     @data = User.where('id = ?', 4)
    #   end
    #   @failed = nil
    # when "purchases"
    #   @data = Purchase.all
    #   @failed = nil
    # when "cards"
    #   @data = Card.all
    #   @failed = nil
    # else
    #   @data = nil
    #   @failed = "error, somehow something went wrong"
    # end

    # return @data
  end
end