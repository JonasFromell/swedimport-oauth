class CreateOauthUsers < ActiveRecord::Migration
  def change
    create_table :oauth_users do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, null: false, default: 0
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      ## Attribtues
      t.string :first_name, null: false
      t.string :last_name, null: false

      t.timestamps
    end

    add_index :oauth_users, :email, unique: true
  end
end
