class CreateChurchApps < ActiveRecord::Migration[5.0]
  def change
    create_table :church_apps do |t|
      t.integer :user_id
      t.string :name
      t.string :church_app_id
      t.string :address1
      t.string :address3  

      t.timestamps
    end
  end
end
