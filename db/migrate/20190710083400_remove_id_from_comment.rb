class RemoveIdFromComment < ActiveRecord::Migration[5.2]
  def change
    remove_column :comments, :novel_contents_id, :integer
  end
end
