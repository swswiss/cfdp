class AddNewFieldsToFlaws < ActiveRecord::Migration[7.2]
  def change
    add_column :flaws, :aprecierea_starii_tehnice, :string
    add_column :flaws, :masuri_recomandate, :string
  end
end
