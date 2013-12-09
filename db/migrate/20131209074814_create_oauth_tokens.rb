class CreateOauthTokens < ActiveRecord::Migration
  def change
    create_table :oauth_tokens do |t|
      t.belongs_to :client

      t.string :token,  null: false
      t.string :refresh_token, default: nil

      t.datetime :expires_at

      t.timestamps
    end

    add_index :oauth_tokens, :client_id
    add_index :oauth_tokens, :token
    add_index :oauth_tokens, :refresh_token
    add_index :oauth_tokens, [:client_id, :token]
  end
end
