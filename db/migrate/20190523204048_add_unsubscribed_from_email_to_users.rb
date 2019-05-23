class AddUnsubscribedFromEmailToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :unsubscribed_from_email, :boolean, default: false
  end
end
