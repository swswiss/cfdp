class CreateEarns < ActiveRecord::Migration[7.2]
  def change
    create_table :earns do |t|
      t.string :date
      t.string :income
      t.string :log

      t.timestamps
    end
  end
end
