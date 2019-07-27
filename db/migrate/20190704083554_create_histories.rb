class CreateHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :histories, :options => 'ENGINE=InnoDB ROW_FORMAT=DYNAMIC' do |t|
      t.integer :user_id
      t.integer :novel_contents_id

      t.timestamps
    end
  end
end
