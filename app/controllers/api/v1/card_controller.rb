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

			private
			def card_params
				params.require(:card).permit(:user_id, :card_number, :holder_name, :zip_code, :expiration_date, :csv_code)
			end
		end
	end
end


