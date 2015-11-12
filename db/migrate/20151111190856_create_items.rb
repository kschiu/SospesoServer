class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.integer :store_id
      t.string :name
      t.integer :price

      t.timestamps null: false
    end
  end
end
