class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.integer :hn_id, null: false, index: true
      t.string :by, null: false
      t.string :title, null: false
      t.string :url, null: false
      t.boolean :archived, null: false, default: false

      t.timestamps null: false
    end
  end
end
