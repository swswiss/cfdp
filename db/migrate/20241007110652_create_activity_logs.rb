class CreateActivityLogs < ActiveRecord::Migration[7.2]
  def change
    create_table :activity_logs do |t|
      t.references :user, null: false, foreign_key: true
      t.string :action
      t.string :trackable_type
      t.integer :trackable_id
      t.datetime :timestamp

      t.timestamps
    end
  end
end
