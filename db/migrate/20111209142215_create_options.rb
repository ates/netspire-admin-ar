class CreateOptions < ActiveRecord::Migration
  def change
    create_table :options do |t|
      t.references :service, :null => false
      t.string :name, :null => false
      t.string :title, :null => false
      t.boolean :required, :null => false, :default => false
      t.boolean :overridable, :null => false, :default => false
      t.integer :value_type, :null => false
      t.timestamps
    end
  end
end
