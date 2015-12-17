module Api
  # Holds the first version of the API controller.
  module V1
		class CardController < ApplicationController
			skip_before_filter :verify_authenticity_token

			def create
				@card = Card.new(card_params)
				if @card.save
					render json: {"message" => "Successfully added card"}
				else
					render json: {"message" => "Failed to add card"}
				end
			end

		end
	end
end


