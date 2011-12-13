class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.references :account, :null => false
      t.decimal :amount, :precision => 12, :scale => 2, :null => false
      t.integer :code, :null => false
      t.string :comment
      t.timestamps
    end
  end
end
