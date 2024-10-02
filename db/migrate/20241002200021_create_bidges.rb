class CreateBidges < ActiveRecord::Migration[7.2]
  def change
    create_table :bidges do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
