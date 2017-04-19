class CreateUsersTable < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |table|
      table.string :username
      table.string :password
    end
  end
end
