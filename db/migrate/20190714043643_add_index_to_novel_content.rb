class AddIndexToNovelContent < ActiveRecord::Migration[5.2]
  def change
    add_index :novel_contents, :novel_content_title
  end
end
