class CreateSettings < ActiveRecord::Migration[6.1]
  def change
    create_table :settings do |t|
      t.boolean :is_use_line, default: false
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
