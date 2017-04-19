class CreatePostsTable < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |table|
      table.datetime :date
      table.string :content
    end
  end
end
