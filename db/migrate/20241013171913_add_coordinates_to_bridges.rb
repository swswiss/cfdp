class AddCoordinatesToBridges < ActiveRecord::Migration[7.2]
  def change
    add_column :bridges, :latitude, :float
    add_column :bridges, :longitude, :float
  end
end
