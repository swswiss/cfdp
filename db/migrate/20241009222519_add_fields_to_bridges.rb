class AddFieldsToBridges < ActiveRecord::Migration[7.2]
  def change
    add_column :bridges, :latime_carosabila, :string
    add_column :bridges, :latime_trotuar, :string
    add_column :bridges, :numar_grinzi, :string
    add_column :bridges, :numar_antretoaze, :string
  end
end
