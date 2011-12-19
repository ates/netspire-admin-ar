class CreatePermissions < ActiveRecord::Migration
  def change
    create_table :permissions do |t|
      t.string :subject_class, :null => false
      t.string :action, :null => false
      t.string :name, :null => false
      t.text :description
      t.timestamps
    end
  end
end
