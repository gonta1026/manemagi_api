class CreateClaims < ActiveRecord::Migration[6.1]
  def change
    create_table :claims do |t|
      t.boolean :is_line_notice, null: false, default: false
      t.boolean :is_line_noticed, null: false, default: false
      t.boolean :is_receipt_line_noticed, null: false, default: false
      t.boolean :is_receipt, null: false, default: false
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end