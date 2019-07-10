class AddIdToHistory < ActiveRecord::Migration[5.2]
  def change
    add_column :histories, :novel_content_id, :integer
  end
end
