class CreateMyProviders < ActiveRecord::Migration[6.0]
  def change
    create_table :my_providers do |t|
      t.string :identifier_value
      t.references :user, null: false, foreign_key: true
      t.references :provider, null: false, foreign_key: true

      t.timestamps
    end
  end
end
