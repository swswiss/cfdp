class AddFieldsToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :firstname, :string
    add_column :users, :lastname, :string
    add_column :users, :username, :string
    add_index :users, :username, unique: true
  end
end