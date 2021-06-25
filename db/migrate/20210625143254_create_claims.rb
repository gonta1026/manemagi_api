class CreateClaims < ActiveRecord::Migration[6.1]
  def change
    create_table :claims do |t|
      t.boolean :is_line_notice, default: false
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
