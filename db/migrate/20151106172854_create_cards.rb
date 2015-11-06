class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.integer :user_id
      t.string :card_number
      t.string :holder_name
      t.string :zip_code
      t.date :expiration_date
      t.string :csv_code

      t.timestamps
    end
  end
end
