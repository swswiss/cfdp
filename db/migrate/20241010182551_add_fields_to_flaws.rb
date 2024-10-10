class AddFieldsToFlaws < ActiveRecord::Migration[7.2]
  def change
    add_column :flaws, :nr_defecte_c1, :string
    add_column :flaws, :nr_defecte_c2, :string
    add_column :flaws, :nr_defecte_c3, :string
    add_column :flaws, :nr_defecte_c4, :string
    add_column :flaws, :nr_defecte_c5, :string
    add_column :flaws, :depunct_max_di_c1, :string
    add_column :flaws, :depunct_max_di_c2, :string
    add_column :flaws, :depunct_max_di_c3, :string
    add_column :flaws, :depunct_max_di_c4, :string
    add_column :flaws, :depunct_max_di_c5, :string
    add_column :flaws, :val_indice_c1, :string
    add_column :flaws, :val_indice_c2, :string
    add_column :flaws, :val_indice_c3, :string
    add_column :flaws, :val_indice_c4, :string
    add_column :flaws, :val_indice_c5, :string
    add_column :flaws, :indice_total_calitate, :string
  end
end
