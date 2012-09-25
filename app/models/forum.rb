class Forum < ActiveRecord::Base
  has_many :topics, :dependent => :destroy

  validates_presence_of :name
end
