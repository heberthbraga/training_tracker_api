class CreateIdentities < ActiveRecord::Migration[6.0]
  def change
    create_table :identities do |t|
      t.string :provider
      t.string :uuid
      t.string :access_token
      t.references :user, null: false, foreign_key: true
      t.datetime :expire_at

      t.timestamps
    end
  end
end
