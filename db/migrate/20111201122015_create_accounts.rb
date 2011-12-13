class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :login, :null => false
      t.string :password, :null => false
      t.boolean :active, :null => false, :default => true
      t.decimal :balance, :precision => 20, :scale => 10, :default => 0
      t.timestamps
    end
  end
end
