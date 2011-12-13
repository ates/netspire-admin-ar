class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.references :option, :null => false
      t.references :assigned_service
      t.references :service_link
      t.string :value, :null => false
      t.timestamps
    end
  end
end
