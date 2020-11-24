class CreateMoves < ActiveRecord::Migration[6.0]
  def change
    create_table :moves do |t|
      t.date :moving_date

      t.timestamps
    end
  end
end
