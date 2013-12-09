class CreateOauthClients < ActiveRecord::Migration
  def change
    create_table :oauth_clients do |t|
      t.string :name, null: false
      t.string :application_id, null: false
      t.string :application_secret, null: false
      t.string :redirect_uri, null: false
    end

    add_index :oauth_clients, :application_id
    add_index :oauth_clients, [:application_id, :application_secret], unique: true
    add_index :oauth_clients, [:application_id, :redirect_uri], unique: true
  end
end
