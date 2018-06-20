ActiveRecord::Schema.define do
  self.verbose = false

  create_table :virtuous_access_tokens, force: trues do |t|
    t.text :token
    t.datetime :expiry
    t.boolean :active, default: 0
    t.timestamps
  end
end
