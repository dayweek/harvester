class DeviseCreateAdmins < ActiveRecord::Migration
  def self.up
    create_table(:admins) do |t|
      t.string :username, :null => false
      t.database_authenticatable :null => false
      t.rememberable
      t.trackable

      # t.encryptable
      # t.confirmable
      t.lockable :lock_strategy => :failed_attempts, :unlock_strategy => :time
      # t.token_authenticatable


      t.timestamps
    end

    add_index :admins, :email,                :unique => true
    add_index :admins, :username,                :unique => true
    #add_index :admins, :reset_password_token, :unique => true
    # add_index :admins, :confirmation_token,   :unique => true
    # add_index :admins, :unlock_token,         :unique => true
    # add_index :admins, :authentication_token, :unique => true
  end

  def self.down
    drop_table :admins
  end
end
