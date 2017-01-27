class AddDeletedAtToPoint < ActiveRecord::Migration[5.0]
  def change
    add_column :points, :deleted_at, :datetime
    add_index :points, :deleted_at
  end
end
