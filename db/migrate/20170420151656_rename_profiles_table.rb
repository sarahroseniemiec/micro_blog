class RenameProfilesTable < ActiveRecord::Migration[5.0]
  def change
    rename_table :profile, :profiles
  end
end
