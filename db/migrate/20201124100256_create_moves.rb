class CreateMoves < ActiveRecord::Migration[6.0]
  def change
    create_table :moves do |t|
      t.date :moving_date
      t.string :street_name
      t.string :street_number
      t.string :zip
      t.string :city

      t.timestamps
    end
  end
end
