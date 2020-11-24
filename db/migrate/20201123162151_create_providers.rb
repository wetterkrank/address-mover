class CreateProviders < ActiveRecord::Migration[6.0]
  def change
    create_table :providers do |t|
      t.string :name
      t.string :identifier_name
      t.string :description
      t.string :category
      t.string :provider_email
     
      t.timestamps
    end
  end
end
