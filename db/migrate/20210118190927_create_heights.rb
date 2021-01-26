class CreateHeights < ActiveRecord::Migration[6.0]
  def change
    create_table :heights do |t|
      t.integer :value
      t.references :system_of_unit, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
