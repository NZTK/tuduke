class CreateNovels < ActiveRecord::Migration[5.2]
  def change
    create_table :novels, :options => 'ENGINE=InnoDB ROW_FORMAT=DYNAMIC' do |t|
      t.integer :user_id
      t.integer :novel_title
      t.text :novel_about
      t.datetime :deleted_at
      t.integer :genre_id
      t.integer :impressions_count, default: 0

      t.timestamps
    end
    add_index :novels, :novel_title
  end
end
