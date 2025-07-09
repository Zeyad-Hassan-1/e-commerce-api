class AddEmailConfirmationboolToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :email_confirmed, :boolean
  end
end
