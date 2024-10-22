class CreateIntegrations < ActiveRecord::Migration[7.2]
  def change
    create_table :integrations do |t|
      t.string :integration_type

      t.timestamps
    end
  end
end
