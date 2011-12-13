class CreateServiceLinks < ActiveRecord::Migration
  def change
    create_table :service_links do |t|
      t.references :account, :null => false
      t.references :assigned_service, :null => false
      t.boolean :scheduled, :null => false, :default => false
      t.boolean :expiring, :null => false, :default => false
      t.boolean :active, :null => false, :default => true
      t.timestamp :start_at
      t.timestamp :expires_at
      t.timestamps
    end
  end
end
