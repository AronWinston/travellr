class AddContentToPosts < ActiveRecord::Migration[5.2]
  def change
    change_table :posts do |t|
    t.string :image_url
  end
end
end
