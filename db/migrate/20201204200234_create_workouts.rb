class CreateWorkouts < ActiveRecord::Migration[6.0]
  def change
    create_table :workouts do |t|
      t.integer :position
      t.references :activity, null: false, foreign_key: true

      t.timestamps
    end
  end
end
