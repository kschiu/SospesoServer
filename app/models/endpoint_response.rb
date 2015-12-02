class EndpointResponse
  attr_reader :failed

  def initialize(params)
    # this is general enough to encompass all endpoints
    # takes a string like "user" and converts it to the class User
    # so we can then do User.all, User.where(), etc.
    temp_data = params[:endpoint].singularize.classify.constantize.all
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
        temp_user_list = temp_data.where('id = ?', params[:id])
        if temp_user_list.length == 0
          @data = nil
          @failed = "error, that user does not exist in the system"
        else
          # there should only be one user in the system with an id
          # need to check whether it should be pluralized or not
          begin
            @data = temp_user_list[0].send(params[:related_endpoint])
          rescue
            @data = temp_user_list[0].send(params[:related_endpoint].pluralize)
          end
          @failed = nil
        end
      end
    # otherwise, if there's a specified id, return that single record
    elsif !params[:id].nil?
      @data = temp_data.where('id = ?', params[:id])
      @failed = nil
    # if there aren't any other specifications, just return all records
    else
      @data = temp_data
      @failed = nil
    end
  
  end
end