class AddWordUniquenessIndex < ActiveRecord::Migration
  def self.up
    add_index :words, :word, :unique => true
  end

  def self.down
    remove_index :words, :word
  end
end
