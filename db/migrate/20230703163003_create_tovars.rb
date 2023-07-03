class CreateTovars < ActiveRecord::Migration[7.0]
  def change
    create_table :tovars do |t|
      t.string :name, null: false
      t.string :artic
      t.string :razd
      t.string :sort
      t.decimal :price, precision: 10, scale: 2, null: false
      t.integer :code, null: false

      t.timestamps
    end
  end
end
