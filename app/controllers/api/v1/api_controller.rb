# use POST via HTTPS
# symlink protected
# double handshake
module Api
  # Holds the first version of the API controller.
  module V1
    # This controller is in a API/v1 folder to allow for
    # for future versions of the API to coexist with this one in the future.
    # Changes are not expected, but this would allow for changes to be more easily
    # made to the API in the future.
    class ApiController < ApplicationController
      # Allow POST request to be made from another application.
      # No CSRF concern, since the post request includes API key credentials.
      skip_before_filter :verify_authenticity_token
      
      # Validate and fetch the key data before processing the API request.
      # before_filter :verify_access_with_api_key

      # Used to process all API requests. 
      def index
        # if the endpoint is the demo endpoint for checking credentials,
        # just return a straightforward success response
        # if params[:endpoint] == "demo_endpoint"
        # render json: JSON(User.all), status: 200
        # puts JSON(User.all)
        endpoint_request = EndpointRequest.new(params)
        puts endpoint_request
        puts "request is: "
        puts request
        unless endpoint_request.failed
          response = EndpointResponse.new(params, request)
          unless response.failed
            render json: response, status: 200
            # render json: { "endpoint" => params[:endpoint], "data" => response.data}, status: 200
          else
            render json: { "message" => response.failed }
          end
        else
          render json: {"message" => request.failed}
        end
        # else
        #   # If the params POSTed are not a valid combination of filters to use, i
        #   # the "request" will fail.
        #   request = EndpointRequest.new(@user_key, params)
        #   # request.failed is an error message if the filters aren't permitted for this key.
        #   unless request.failed
        #     # The 'response' will fail if there are no columns for this key for this
        #     # resource, or if resource name was invalid.
        #     response = EndpointResponse.new(@user_key, params)
        #     unless response.failed
        #       render json: JSON(response.to_hash), status: 200
        #     else
        #       # response.failed is an error message if something went wrong.
        #       render json: {"message" => response.failed }
        #     end
        #   else
        #     render json: {"message" => request.failed }
        #   end
        # end
      end
      
      private
      # Returns whether the passed-in api_key exists in our system,
      # and is confirmed/not expired/active.
      def key_matches?(api_key)
        puts "the passed in api_key is"
        puts api_key
        puts "the settings hash is"
        puts SETTINGS
        puts "the settings hash api key is"
        puts SETTINGS[:api_key]
        return api_key == SETTINGS[:api_key]
      end

      # Used in the before_filter callback to verify whether or not
      # the api key and andrew ID passed in.
      def verify_access_with_api_key
        # grab the api key from the post request headers
        api_key   = request.headers["HTTP_API_KEY"]
        andrew_id = request.headers["HTTP_ANDREW_ID"]
        if (api_key.nil?)
          render json: {error: "Error, bad request"}, status: 400
        end
        if !(key_matches?(api_key))
          render json: {error: "Error, unauthorized user or API key"}, status: 401
        end
      end
    end
  end
end