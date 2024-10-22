class CreateUserIntegrations < ActiveRecord::Migration[7.2]
  def change
    create_table :user_integrations do |t|
      t.references :user, null: false, foreign_key: true
      t.references :integration, null: false, foreign_key: true

      t.timestamps
    end
  end
end
