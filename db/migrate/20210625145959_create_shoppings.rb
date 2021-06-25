class CreateShoppings < ActiveRecord::Migration[6.1]
  def change
    create_table :shoppings do |t|
      t.integer :price, null: false
      t.text :description
      t.datetime :date, null: false
      t.boolean :is_line_notice, null: false, default: false
      t.references :user, null: false, foreign_key: true
      t.references :shop, null: false, foreign_key: true
      t.references :claim, foreign_key: true
      t.timestamps
    end
  end
end
