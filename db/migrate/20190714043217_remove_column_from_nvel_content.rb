class RemoveColumnFromNvelContent < ActiveRecord::Migration[5.2]
  def change
    remove_column :novel_contents, :impressions_count, :integer
  end
end
