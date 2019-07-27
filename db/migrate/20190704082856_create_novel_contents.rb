class CreateNovelContents < ActiveRecord::Migration[5.2]
  def change
    create_table :novel_contents, :options => 'ENGINE=InnoDB ROW_FORMAT=DYNAMIC' do |t|
      t.integer :novel_id
      t.integer :user_id
      t.string :novel_content_title
      t.text :novel_content_text
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
