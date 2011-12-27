class CreateAssignedServices < ActiveRecord::Migration
  def change
    create_table :assigned_services do |t|
      t.references :service, :null => false
      t.references :plan, :null => false
      t.references :billing_cycle, :null => false
      t.decimal :periodic_fee, :precision => 12, :scale => 2, :default => 0, :null => false
      t.decimal :setup_fee, :precision => 12, :scale => 2, :default => 0, :null => false
      t.integer :charge_mode, :null => false
      t.timestamps
    end
  end
end
