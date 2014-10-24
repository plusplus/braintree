class CreatePledges < ActiveRecord::Migration
  def change
    create_table :pledges do |t|
      t.string :name
      t.integer :amount
      t.integer :transaction_reference
      t.timestamps
    end
  end
end
