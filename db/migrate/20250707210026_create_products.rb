class CreateProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :products do |t|
      t.text :name
      t.text :description
      t.float :price
      t.json :colors
      t.json :images
      t.json :sizes
      t.json :categories

      t.timestamps
    end
  end
end
