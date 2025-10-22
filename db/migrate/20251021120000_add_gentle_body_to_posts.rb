class AddGentleBodyToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :gentle_body, :text
  end
end
