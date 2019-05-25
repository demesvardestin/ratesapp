class CreateHelpTickets < ActiveRecord::Migration[5.0]
  def change
    create_table :help_tickets do |t|
      t.boolean :resolved, default: false
      t.string :email
      t.text :content

      t.timestamps
    end
    
    add_column :users, :unsubscribed_from_promotional_emails, :boolean, default: false
  end
end
