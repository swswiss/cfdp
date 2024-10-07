class AddNameToActivityLogs < ActiveRecord::Migration[7.2]
  def change
    add_column :activity_logs, :name, :string
  end
end
