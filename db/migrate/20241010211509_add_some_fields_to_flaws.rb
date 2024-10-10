class AddSomeFieldsToFlaws < ActiveRecord::Migration[7.2]
  def change
    add_column :flaws, :corespunde_ordinul, :string
    add_column :flaws, :f1_depunct, :string
    add_column :flaws, :f1, :string
    add_column :flaws, :clasa_incarcare, :string
    add_column :flaws, :f2, :string
    add_column :flaws, :f2_depunct, :string
    add_column :flaws, :tipul_suprastructurii, :string
    add_column :flaws, :durata_exploatare, :string
    add_column :flaws, :f3_depunct, :string
    add_column :flaws, :f3, :string
    add_column :flaws, :f4_depunct, :string
    add_column :flaws, :f4, :string
    add_column :flaws, :f5_depunct, :string
    add_column :flaws, :f5, :string
    add_column :flaws, :ist_c, :string
    add_column :flaws, :ist_f, :string
    add_column :flaws, :ist_total, :string
  end
end
