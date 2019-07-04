class Novels < ActiveRecord::Migration[5.2]
  def change
  	drop_table :novels
  end
end
