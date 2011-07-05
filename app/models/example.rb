class Example < ActiveRecord::Base
  attr_accessible :content

  belongs_to :word

  validates :content, :presence => true, :length => { :maximum => 255 }
  validates :word_id, :presence => true

  default_scope :order => 'examples.created_at ASC'
end
