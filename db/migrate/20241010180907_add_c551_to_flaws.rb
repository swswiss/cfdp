class AddC551ToFlaws < ActiveRecord::Migration[7.2]
  def change
    add_column :flaws, :c5_51, :string
  end
end
