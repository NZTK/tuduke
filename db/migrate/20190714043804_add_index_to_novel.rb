class AddIndexToNovel < ActiveRecord::Migration[5.2]
  def change
  	add_index :novels, :novel_title
  end
end
