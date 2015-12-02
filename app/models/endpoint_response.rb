class EndpointResponse
  attr_reader :failed

  def initialize(params)
    # this is general enough to encompass all endpoints
    # takes a string like "user" and converts it to the class User
    # so we can then do User.all, User.where(), etc.
    temp_data = params[:endpoint].singularize.classify.constantize
    # return the related records for a specific id
    if !params[:id].nil? and !params[:related_endpoint].nil?
      # first assert that the attempted request for a relation is valid,
      # not a "destroy" or something, but a real association
      all_ass_names = temp_data.reflect_on_all_associations.map{|q| q.class_name}
      puts all_ass_names
      if !all_ass_names.include?(params[:related_endpoint].singularize.classify)
        @data = nil
        @failed = "error, that's not a valid association of #{params[:endpoint]}"
      else
        temp_user = temp_data.where('id = ?', params[:id])
        puts temp_user
        @data = temp_user.send(params[:related_endpoint])
        @failed = nil
      end
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