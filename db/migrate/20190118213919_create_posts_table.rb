class CreatePostsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :comment
      t.datetime :created_at
      t.datetime :updated_at
  end
end
end
