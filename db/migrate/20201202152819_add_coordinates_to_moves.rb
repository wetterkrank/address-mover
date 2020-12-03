class AddCoordinatesToMoves < ActiveRecord::Migration[6.0]
  def change
    add_column :moves, :latitude, :float
    add_column :moves, :longitude, :float
  end
end
