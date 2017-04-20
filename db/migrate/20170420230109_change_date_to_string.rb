class ChangeDateToString < ActiveRecord::Migration[5.0]
  def change
    change_column :posts, :date, :string
  end
end
