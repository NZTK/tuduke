class RemoveNovelTitleFromNovel < ActiveRecord::Migration[5.2]
  def change
    remove_column :novels, :novel_title, :integer
  end
end
