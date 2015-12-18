class CreatePurchasedItems < ActiveRecord::Migration
  def change
    create_table :purchased_items do |t|
      t.integer :item_id
      t.integer :purchase_id
      t.integer :buyer_id
      t.integer :redeemer_id
      t.boolean :is_redeemed
      t.string :message

      t.timestamps
    end
  end
end
