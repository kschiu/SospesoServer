module Api
  module V1
		class RedeemController < ApplicationController
			skip_before_filter :verify_authenticity_token

			def redeem
        @purchased_item = PurchasedItem.find(params[:id])
				if @purchased_item.is_redeemed
					render json: {"message" => @purchased_item.item.name + " has already been redeemed."}
				else
          @purchased_item.is_redeemed = true
          @purchased_item.save!
					render json: {"message" => "Please give a " + @purchased_item.item.name + " to the redeemer!"}
				end
			end

		end
	end
end


