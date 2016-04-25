class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.boolean :admin, default: false
      t.string :password_digest
      t.string :remember_digest
      t.string :picture

      t.timestamps null: false
    end
    add_index :users, :email, unique: true
  end
end
