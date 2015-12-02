class EndpointResponse
  attr_reader :failed

  def initialize(params)
    # this is general enough to encompass all endpoints
    # takes a string like "user" and converts it to the class User
    # so we can then do User.all, User.where(), etc.
    klass = params[:endpoint].singularize.classify.constantize
    @data = nil
    # return the related records for a specific id
    if !params[:id].nil? and !params[:related_endpoint].nil?
      # first assert that the attempted request for a relation is valid,
      # not a "destroy" or something, but a real association
      all_ass_names = klass.reflect_on_all_associations.map{|q| q.class_name}
      puts all_ass_names
      if !all_ass_names.include?(params[:related_endpoint].singularize.classify)
        @failed = "error, that's not a valid association of #{params[:endpoint]}"
      else
        temp_user_list = klass.where('id = ?', params[:id])
        if temp_user_list.length == 0
          @failed = "error, that user does not exist in the system"
        else
          # there should only be one user in the system with an id
          # need to check whether it should be pluralized or not
          if klass.instance_methods.include?(params[:related_endpoint].to_sym)
            actual_association = params[:related_endpoint]
          elsif klass.instance_methods.include?(params[:related_endpoint].singularize.to_sym)
            actual_association = params[:related_endpoint].singularize
          elsif klass.instance_methods.include?(params[:related_endpoint].pluralize.to_sym)
            actual_association = params[:related_endpoint].pluralize
          else
            @failed = "error, the related endpoint does not exist"
            return @data
          end
          #
          @data = temp_user_list[0].send(actual_association)
          @failed = nil
        end
      end
    # otherwise, if there's a specified id, return that single record
    elsif !params[:id].nil?
    # there should only be one user in the system with an id
      @data = klass.where('id = ?', params[:id])[0]
      @failed = nil
    # if there aren't any other specifications, just return all records
    else
      @data = klass.all
      @failed = nil
    end
  
  end
end