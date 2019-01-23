class ChangeTablePosts < ActiveRecord::Migration[5.2]
  def change 
    change_table :posts do |t|
    t.remove :comment
    t.string :content
  end
end
end

