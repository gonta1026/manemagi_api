class CreateSettings < ActiveRecord::Migration[6.1]
  def change
    create_table :settings do |t|
      t.boolean :is_use_line, null: false, default: false
      t.string :line_notice_token, unique:true
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
