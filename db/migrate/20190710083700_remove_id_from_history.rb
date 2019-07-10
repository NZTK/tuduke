class RemoveIdFromHistory < ActiveRecord::Migration[5.2]
  def change
    remove_column :histories, :novel_contents_id, :integer
  end
end
