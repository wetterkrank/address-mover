class AddInfoToProviders < ActiveRecord::Migration[6.0]
  def change
    add_column :providers, :update_method, :string
    add_column :providers, :api_endpoint, :string
  end
end
