class CreateAdminPermissions < ActiveRecord::Migration
  def change
    create_table :admin_permissions do |t|
      t.references :admin
      t.references :permission
      t.timestamps
    end
  end
end
