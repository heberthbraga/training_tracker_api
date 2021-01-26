class CreateTrainingSessions < ActiveRecord::Migration[6.0]
  def change
    create_table :training_sessions do |t|
      t.string :name
      t.timestamp :deadline
      t.integer :owner_id

      t.timestamps
    end
  end
end
