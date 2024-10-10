class CreateFlaws < ActiveRecord::Migration[7.2]
  def change
    create_table :flaws do |t|
      t.references :bridge, null: false, foreign_key: true

      t.timestamps
    end
  end
end
