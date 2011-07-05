class Word < ActiveRecord::Base
  attr_accessible :word

  has_many :definitions, :dependent => :destroy
  has_many :examples,    :dependent => :destroy

  default_scope :order => 'words.word ASC'

  validates :word, :presence   => true,
                   :length     => { :maximum => 50 },
                   :uniqueness => { :case_sensitive => false }

  def <=>(word)
    self.word <=> word.word
  end
end
