class AddBlockedToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :blocked, :boolean, default: false
  end
end
