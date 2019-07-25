class AddAdminToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :user_about, :text
    add_column :users, :admin, :boolean, default: false
    add_column :users, :deleted_at, :datetime
  end
end
