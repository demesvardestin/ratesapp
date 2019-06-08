class CreateStripeLogs < ActiveRecord::Migration[5.0]
  def change
    create_table :stripe_logs do |t|
      t.string :log_type
      t.text :additional_details
      t.string :stripe_id
      t.string :account
      t.string :authorization
      t.string :disabled_reasons
      t.string :due_by
      t.string :fields_needed
      t.string :destination

      t.timestamps
    end
  end
end
