class RemoveIdFromLike < ActiveRecord::Migration[5.2]
  def change
    remove_column :likes, :novel_contents_id, :integer
  end
end
