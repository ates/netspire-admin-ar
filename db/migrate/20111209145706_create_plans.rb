class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.string :name, :null => false
      t.string :code, :null => false
      t.boolean :active, :null => false, :default => true
      t.boolean :legacy, :null => false, :default => false
      t.timestamp :expires_at
      t.timestamps
    end
  end
end
