class CreateAssignedServices < ActiveRecord::Migration
  def change
    create_table :assigned_services do |t|
      t.references :service, :null => false
      t.references :plan, :null => false
      t.timestamps
    end
  end
end
