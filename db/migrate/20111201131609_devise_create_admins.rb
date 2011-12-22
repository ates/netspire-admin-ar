class DeviseCreateAdmins < ActiveRecord::Migration
  def change
    create_table(:admins) do |t|
      t.string :login, :null => false
      t.database_authenticatable :null => false, :encryptor => :sha1
      t.token_authenticatable
      t.rememberable
      t.boolean :active, :null => false, :default => true
      t.timestamps
    end

    add_index :admins, :login,                :unique => true
    add_index :admins, :authentication_token, :unique => true
  end

end
