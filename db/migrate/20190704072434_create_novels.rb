class CreateNovels < ActiveRecord::Migration[5.2]
  def change
    create_table :novels do |t|
      t.integer :user_id
      t.integer :genre_id
      t.string :novel_title
      t.text :novel_about
      t.integer  :impressions_count, default: 0
      t.datetime :deleted_at



    end
  end
end
