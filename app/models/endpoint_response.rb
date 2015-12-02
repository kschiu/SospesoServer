class EndpointResponse
  attr_reader :failed

  def initialize(params)
    # this is general enough to encompass all endpoints
    # takes a string like "user" and converts it to the class User
    # so we can then do User.all, User.where(), etc.
    temp_data = params[:endpoint].singularize.classify.constantize
    # return the related records for a specific id
    if !params[:id].nil? and !params[:related_endpoint].nil?
      # this is broken, fix it
      @data = temp_data.all
      @failed = nil
    # otherwise, if there's a specified id, return that single record
    elsif !params[:id].nil?
      @data = temp_data.where('id = ?', params[:id])
      @failed = nil
    # if there aren't any other specifications, just return all records
    else
      @data = temp_data.all
      @failed = nil
    end
    
    return @data

  end
end