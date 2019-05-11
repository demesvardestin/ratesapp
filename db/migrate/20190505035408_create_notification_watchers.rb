class CreateNotificationWatchers < ActiveRecord::Migration[5.0]
  def change
    create_table :notification_watchers do |t|
      t.integer :user_id
      t.boolean :checked

      t.timestamps
    end
  end
end
