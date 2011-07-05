class Definition < ActiveRecord::Base
  attr_accessible :content

  belongs_to :word

  validates :content, :presence => true, :length => { :maximum => 100 }
  validates :word_id, :presence => true

  default_scope :order => 'definitions.created_at ASC'
end
