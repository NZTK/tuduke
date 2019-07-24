class ChangeCulmnToNovel < ActiveRecord::Migration[5.2]
  def change
    change_column_null :novels, :genre_id, false
  end
end
