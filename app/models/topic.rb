class Topic < ActiveRecord::Base
  belongs_to :forum
  belongs_to :user
  has_many :posts, :inverse_of => :topic, :dependent => :destroy

  validates_numericality_of :forum_id, :user_id, :posts_count
  validates_presence_of :title

  accepts_nested_attributes_for :posts

  def last_post
    self.posts.order("created_at DESC").first
  end
end
