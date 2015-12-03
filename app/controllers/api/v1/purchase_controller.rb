module Api
  # Holds the first version of the API controller.
  module V1
		class PurchaseController < ApplicationController
			skip_before_filter :verify_authenticity_token

			def create
				@purchase = Purchase.new(card_params)
				@purchased_item = PurchasedItem.new(purchased_items_params)
				if @purchase.save && @purchased_item.save
					render json: {"message" => "Successfully added purchased"}
				else
					render json: {"message" => "Failed to purchase"}
				end
			end

			private
			def purchased_items_params
				params.require(:purchased_items).permit(:item_id, :purchase_id, :buyer_id, :redeemer_id, :is_redeemed)
			end

			def purchases_params
				params.require(:purchases).permit(:user_id, :card_id)
			end

		end

	end
end


