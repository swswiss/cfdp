class CreateFlawInstances < ActiveRecord::Migration[7.2]
  def change
    create_table :flaw_instances do |t|
      t.references :instance_bridge, null: false, foreign_key: true

      t.timestamps
    end
  end
end
