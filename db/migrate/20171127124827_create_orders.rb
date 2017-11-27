class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.references :user, foreign_key: true
      t.string :receving_name
      t.string :receving_address
      t.integer :status

      t.timestamps
    end
  end
end
