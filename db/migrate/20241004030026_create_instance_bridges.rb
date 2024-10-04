class CreateInstanceBridges < ActiveRecord::Migration[7.2]
  def change
    create_table :instance_bridges do |t|
      t.references :bridge, null: false, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
