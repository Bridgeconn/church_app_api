class AddMemberBelongsToAdminToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :member_belongs_to_admin, :integer
  end
end
