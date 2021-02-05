class CreateWords < ActiveRecord::Migration[6.1]
  def change
    create_table :words do |t|
      t.string :key
      t.integer :rank
      t.string :pattern
      t.text :message

      t.timestamps
    end
  end
end
