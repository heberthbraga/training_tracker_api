class CreateActivities < ActiveRecord::Migration[6.0]
  def change
    create_table :activities do |t|
      t.string :name
      t.string :activity_type
      t.integer :phases
      t.boolean :completed, default: false
      t.references :timer, null: false, foreign_key: true
      t.references :training_session, null: false, foreign_key: true

      t.timestamps
    end
  end
end
