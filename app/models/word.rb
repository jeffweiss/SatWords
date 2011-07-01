class Word < ActiveRecord::Base
  attr_accessible :word

  validates :word, :presence   => true,
                   :length     => { :maximum => 50 },
                   :uniqueness => { :case_sensitive => false }
end
