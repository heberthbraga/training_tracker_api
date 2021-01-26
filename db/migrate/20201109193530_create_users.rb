class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string    :first_name
      t.string    :last_name
      t.datetime  :birthdate
      t.string    :gender
      t.string    :email
      t.string    :password_digest
      t.boolean   :active, default: true

      t.timestamps
    end
  end
end
