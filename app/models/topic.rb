class Topic < ActiveRecord::Base
  belongs_to :forum
  belongs_to :user

  has_many :posts, :dependent => :destroy
end
