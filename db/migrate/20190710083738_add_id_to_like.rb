class AddIdToLike < ActiveRecord::Migration[5.2]
  def change
    add_column :likes, :novel_content_id, :integer
  end
end
