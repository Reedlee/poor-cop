class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string   :phone
      t.string   :verification_code
      t.datetime :code_confirmed_at
      t.string   :token
      t.datetime :token_expired_at

      t.timestamps
    end
  end
end
