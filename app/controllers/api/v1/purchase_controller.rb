module Api
  module V1
		class PurchaseController < ApplicationController
			skip_before_filter :verify_authenticity_token

			def create
				@purchase = Purchase.new(user_id: params[:user_id],
																 card_id: params[:card_id])
				@purchased_item = PurchasedItem.new(
														item_id: params[:item_id],
														purchase_id: @purchase.id,
														buyer_id: params[:buyer_id],
														redeemer_id: params[:redeemer_id],
														is_redeemed: params[:is_redeemed])
				if @purchase.save && @purchased_item.save
					render json: {"message" => "Successfully added purchased"}
				else
					render json: {"message" => "Failed to purchase"}
				end
			end

			private
			def purchase_params
				params.require(:purchased_items).permit(:item_id, :purchase_id, :buyer_id, :redeemer_id, :is_redeemed, :user_id, :card_id)
			end

		end

	end
end


