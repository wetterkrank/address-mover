class CreatePdfs < ActiveRecord::Migration[6.0]
  def change
    create_table :pdfs do |t|
      t.string :uuid
      t.references :update, null: false, foreign_key: true

      t.timestamps
    end
  end
end
