class AddSlugToBridges < ActiveRecord::Migration[7.2]
  def change
    add_column :bridges, :slug, :string
    add_index :bridges, :slug, unique: true
  end
end
