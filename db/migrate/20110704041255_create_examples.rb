class CreateExamples < ActiveRecord::Migration
  def self.up
    create_table :examples do |t|
      t.string :content
      t.integer :word_id

      t.timestamps
    end

    add_index :examples, :word_id
    add_index :examples, :created_at
  end

  def self.down
    drop_table :examples
  end
end
