class CreateBillingCycles < ActiveRecord::Migration
  def change
    create_table :billing_cycles do |t|
      t.string :name, :null => false
      t.integer :cycle_type, :null => false
      t.boolean :smooth, :null => false, :default => true
      t.integer :unit
      t.integer :length, :null => false, :default => 1
      t.integer :canonical_length, :null => false, :default => 1
      t.timestamps
    end
  end
end
