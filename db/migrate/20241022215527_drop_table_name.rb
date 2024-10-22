class DropTableName < ActiveRecord::Migration[7.0]  # Adjust version if necessary
  def up
    drop_table :integrations
  end
end
