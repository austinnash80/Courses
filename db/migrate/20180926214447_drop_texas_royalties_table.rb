class DropTexasRoyaltiesTable < ActiveRecord::Migration[5.1]
  def up
    drop_table :texas_royalties
  end
  def down
  fail ActiveRecord::IrreversibleMigration
  end
end
