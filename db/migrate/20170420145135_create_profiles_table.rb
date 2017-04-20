class CreateProfilesTable < ActiveRecord::Migration[5.0]
  def change
    create_table :profile do |table|
      table.string :state
      table.string :country
      table.integer :user_id
    end
  end
end
