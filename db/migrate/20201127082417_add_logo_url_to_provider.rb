class AddLogoUrlToProvider < ActiveRecord::Migration[6.0]
  def change
    add_column :providers, :logo_url, :string
  end
end
