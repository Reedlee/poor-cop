class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :phone, null: false, limit: 24
      t.string :verification_code, limit: 10
      t.datetime :code_confirmed_at
      t.string :token
      t.datetime :token_expired_at

      t.timestamps
    end

    add_index :users, :phone, unique: true
    add_index :users, :token, unique: true
  end
end
