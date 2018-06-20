class CreateVirtuousAccessTokens < ActiveRecord::Migration
  def change
    create_table :virtuous_access_tokens do |t|
      t.text :token
      t.datetime :expiry
      t.boolean :active, default: 0
      t.timestamps
    end
  end
end
