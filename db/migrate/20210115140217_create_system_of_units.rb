class CreateSystemOfUnits < ActiveRecord::Migration[6.0]
  def change
    create_table :system_of_units do |t|
      t.string :description
      t.string :symbol

      t.timestamps
    end
  end
end
