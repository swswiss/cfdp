class AddSumaFieldsToFlaw < ActiveRecord::Migration[7.2]
  def change
    add_column :flaws, :suma_c1, :string
    add_column :flaws, :suma_f1, :string
    add_column :flaws, :suma_ist, :string
  end
end
