class CreateBillingPeriods < ActiveRecord::Migration
  def change
    create_table :billing_periods do |t|
      t.references :next
      t.references :billing_cycle, :null => false
      t.timestamp :start_at, :null => false
      t.timestamp :expires_at, :null => false
      t.boolean :expired, :null => false, :default => false
      t.integer :canonical_length, :null => false
      t.integer :iteration, :null => false, :default => 0
      t.timestamps
    end
  end
end
