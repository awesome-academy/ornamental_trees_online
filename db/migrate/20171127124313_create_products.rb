class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name
      t.text :content, :limit => 16777215
      t.references :category, foreign_key: true
      t.decimal :price, default: 0, :precision => 8, :scale => 2
      t.integer :quantity
      t.string :tags
      t.integer :buyer, default: 0

      t.timestamps
    end
  end
end
