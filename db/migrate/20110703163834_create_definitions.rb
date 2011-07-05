class CreateDefinitions < ActiveRecord::Migration
  def self.up
    create_table :definitions do |t|
      t.string :content
      t.integer :word_id

      t.timestamps
    end
    add_index :definitions, :word_id
    add_index :definitions, :created_at
  end

  def self.down
    drop_table :definitions
  end
end
