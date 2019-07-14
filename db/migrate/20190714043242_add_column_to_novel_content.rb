class AddColumnToNovelContent < ActiveRecord::Migration[5.2]
  def change
    add_column :novel_contents, :impressions_count, :integer, default: 0
  end
end
