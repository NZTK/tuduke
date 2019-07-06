class AddNovelTitleToNovel < ActiveRecord::Migration[5.2]
  def change
    add_column :novels, :novel_title, :string
  end
end
