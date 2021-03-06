class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.integer :church_app_id
      t.string :event_name
      t.string :event_venue_name
      t.date :event_end_time
      t.date :event_start_time
      t.string :event_speaker

      t.timestamps
    end
  end
end
