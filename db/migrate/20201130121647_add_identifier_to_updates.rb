class AddIdentifierToUpdates < ActiveRecord::Migration[6.0]
  def change
    add_column :updates, :id_sent, :string
  end
end
