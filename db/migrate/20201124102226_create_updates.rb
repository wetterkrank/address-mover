class CreateUpdates < ActiveRecord::Migration[6.0]
  def change
    create_table :updates do |t|
      t.string :update_status
      t.references :provider, null: false, foreign_key: true
      t.references :move, null:false, foreign_key: true

      t.timestamps
    end
  end
end
