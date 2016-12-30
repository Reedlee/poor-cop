class CreatePoints < ActiveRecord::Migration[5.0]
  def change
    create_table :points do |t|
      t.string :latitude, null:false
      t.string :longitude, null:false

      t.timestamps
    end
  end
end
