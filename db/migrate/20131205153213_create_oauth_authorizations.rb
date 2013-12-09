class CreateOauthAuthorizations < ActiveRecord::Migration
  def change
    create_table :oauth_authorizations do |t|
      t.string :application_id, null: false
      t.string :redirect_uri, null: false
      t.string :code, null: false

      t.datetime :expires_at, null: false

      t.belongs_to :user
    end

    add_index :oauth_authorizations, [:application_id, :redirect_uri]
    add_index :oauth_authorizations, :user_id
  end
end
