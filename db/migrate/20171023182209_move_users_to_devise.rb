class MoveUsersToDevise < ActiveRecord::Migration[5.1]
  def change
    change_table "users" do |t|
      # Database authenticatable
      t.rename :crypted_password, :encrypted_password
      t.rename :salt, :password_salt

      # Confirmable
      t.rename :activation_code, :confirmation_token
      t.index :confirmation_token
      t.rename :activated_at, :confirmed_at
      t.datetime :confirmation_sent_at

      # Recoverable
      t.string :reset_password_token
      t.index :reset_password_token
      t.datetime :reset_password_sent_at

      # Rememberable
      t.datetime :remember_created_at

      # Trackable
      t.integer :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string :current_sign_in_ip
      t.string :last_sign_in_ip

      # Lockable
      t.integer :failed_attempts, default: 0, null: false
      t.remove :failed_login_count, :integer
      t.string :unlock_token
      t.index :unlock_token
      t.datetime :locked_at
    end
  end
end
