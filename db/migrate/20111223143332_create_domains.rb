class CreateDomains < ActiveRecord::Migration
  def change
    create_table :domains do |t|
      t.string :name, :null => false
      t.string :title, :null => false
      t.text :description
      t.boolean :active, :null => false, :default => true
      t.timestamps
    end
  end
end
