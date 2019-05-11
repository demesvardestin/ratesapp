class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.text :content
      t.integer :brand_id
      t.integer :promoter_id
      t.boolean :flagged, default: false

      t.timestamps
    end
  end
end
