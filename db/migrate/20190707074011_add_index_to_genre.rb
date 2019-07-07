class AddIndexToGenre < ActiveRecord::Migration[5.2]
  def change
  	add_index :genres, :genre_name, unique: true
  end
end
