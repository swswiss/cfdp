class RenameBidgeToBridge < ActiveRecord::Migration[7.2]
  def change
    rename_table :bidges, :bridges
  end
end
