class CreateAccountRequests < ActiveRecord::Migration[7.2]
  def change
    create_table :account_requests do |t|
      t.string :email
      t.string :username
      t.string :first_name
      t.string :last_name
      t.string :password
      t.string :status

      t.timestamps
    end
  end
end
