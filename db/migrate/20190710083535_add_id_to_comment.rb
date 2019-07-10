class AddIdToComment < ActiveRecord::Migration[5.2]
  def change
    add_column :comments, :novel_content_id, :integer
  end
end
