class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name
      t.references :category, foreign_key: true
      t.float :price
      t.integer :quantity
      t.string :image

      t.timestamps
    end
  end
end
