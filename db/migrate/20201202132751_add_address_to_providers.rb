class AddAddressToProviders < ActiveRecord::Migration[6.0]
  def change
    add_column :providers, :street_name, :string
    add_column :providers, :street_number, :string
    add_column :providers, :zip, :string
    add_column :providers, :city, :string
  end
end
