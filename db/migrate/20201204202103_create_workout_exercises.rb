class CreateWorkoutExercises < ActiveRecord::Migration[6.0]
  def change
    create_table :workout_exercises do |t|
      t.references :workout, null: false, foreign_key: true
      t.references :muscle_group, null: false, foreign_key: true
      t.references :exercise, null: false, foreign_key: true
      t.integer :weights
      t.integer :series
      t.integer :repetitions
      t.string :image

      t.timestamps
    end
  end
end
