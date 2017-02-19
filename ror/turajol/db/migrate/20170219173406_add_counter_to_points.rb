class AddCounterToPoints < ActiveRecord::Migration[5.0]
  def up
    add_column :points, :counter, :integer, default: 0
    change_column_null :points, :counter, false
  end

  def down
    remove_column :points, :counter, :integer
  end
end
