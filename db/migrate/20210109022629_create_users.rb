class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :userid, null: false
      t.string :password_digest, null: false

      t.timestamps
    end
    add_index :users, :userid, unique: true
  end
end
