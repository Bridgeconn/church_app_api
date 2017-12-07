class AddContactShowToAllToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :contact_show_to_all, :boolean, :default => false, :null => false
  end
end
