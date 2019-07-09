class AddForewordToNovelContent < ActiveRecord::Migration[5.2]
  def change
    add_column :novel_contents, :novel_content_forewords, :string
    add_column :novel_contents, :novel_content_afterwords, :string
  end
end
