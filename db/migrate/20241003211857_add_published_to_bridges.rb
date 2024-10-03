class AddPublishedToBridges < ActiveRecord::Migration[7.2]
  def change
    add_column :bridges, :published, :boolean, null: false, default: false
  end
end
